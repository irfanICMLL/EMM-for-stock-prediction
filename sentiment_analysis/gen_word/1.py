import os
import math
import random
class LR_Uni_Bi():
    
    def __init__ (self, train_dir, test_dir, alpha = 0.01):
        '''
        初始化,设置数据文件目录和学习速率
        '''
        self.train_dir = train_dir
            # 训练文件路径
        self.test_dir = test_dir
            # 测试文件路径
        self.alpha = alpha
            # 学习速率
        self.dic = {}
            # 字典
            # 注:字符和元组都可以做key
    def loadStopWords(self):
        '''
        载入stopwords list

        '''
        for line in open('.\\stopwords.txt'):
            doc=line.split()
            self.stopwords=set(doc)
        
    
            
    def buildUnigram(self, min1=0, sw1=True):
        '''
        build the unigram
        '''
        temp_dic = {}
            # 临时变量，存储unigram的次数，用于min-count过滤
        for fname in os.listdir(self.train_dir):
            for line in open(os.path.join(self.train_dir, fname)):
                for token in line.split():
                    if token not in temp_dic:
                        temp_dic[token] = 1
                    else:
                        temp_dic[token] += 1
        temp_set = set()
            # 临时变量，存储过滤后词
        for word in temp_dic:
            if temp_dic[word] > min1: 
                temp_set.add(word)
        if sw1:
            self.loadStopWords()
            temp_set -= self.stopwords
        count = 0                                 ### 条件为假，if下的语句不会执行吧？
        
        for word in temp_set:
            self.dic[word] = count
            count += 1                           ### 关于set()只存储不重复的元素，将word添加到temp_set中，那每个word的次数不是都为1了吗？
        print 'unigram', len(self.dic)

        
    def buildBigram(self, min2=5, sw2=True):
        '''
        build the bigram
        '''
        self.gram2 = {}
            # 临时变量，存储bigram的次数，用于min-count过滤
        for fname in os.listdir(self.train_dir):
            for line in open(os.path.join(self.train_dir, fname)):
                doc = line.split()
                for i in range(len(doc)-(2-1)):             ### range()本身能实现len(doc)-1,这里是1到len(doc)-2的意思吗？不明白有什么作用？
                    t = tuple(doc[i:i+2])
                    if t not in self.gram2:
                        self.gram2[t] = 1
                    else:
                        self.gram2[t] += 1
        print 'original bigram', len(self.gram2)
        remove_set = set()
        for g in self.gram2:
            if self.gram2[g] <= min2:
                remove_set.add(g)
            if sw2:
                if g[0] in self.stopwords and g[1] in self.stopwords:
                    remove_set.add(g)                      ### 问题同buildunigram()中的相同
        for g in remove_set:
            del self.gram2[g]
        print 'bigram min-count -%d %d ' %(min2, len(self.gram2))
        self.uni_count = len(self.dic)
            # 当前字典维度，表示有效unigram的个数
        count = self.uni_count                             
        for g in self.gram2:
            self.dic[g] = count                    
            count += 1
        print 'bigram', len(self.dic)-self.uni_count
        

    def buildDic(self, min1=0, min2=0, sw1=True, sw2=True):
        '''
        构建bigram和unigram, 都存在dic中
        '''
        self.buildUnigram(min1=min1, sw1=sw1)
            # build the unigram
        self.buildBigram(min2=min2, sw2=sw2)
            # build the bigram
    def getlabel(self):
        '''
        提取训练数据的标签
        '''
        self.train_label = []
        for fname in os.listdir(self.train_dir):
            if fname == 'train_neg.txt':
                label = 0
            else:
                label = 1
            for line in open(os.path.join(self.train_dir, fname)):
                self.train_label.append(label)
        self.test_label = []
        for fname in os.listdir(self.test_dir):
            if fname == 'test_neg.txt':
                label = 0
            else:
                label = 1
            for line in open(os.path.join(self.test_dir, fname)):
                self.test_label.append(label)     ### 最终得到的 self.train_label的元素个数和什么有关？
        
    def sigmoid(self, x):
        '''
        sigmoid function
        '''
        return 1.0 / ( 1 + math.exp(-x) )
    
    def initTheta(self):  
        '''
        随机初始化 Theta
        '''   
        self.theta = []
        for i in range(len(self.dic)):
            self.theta.append(random.random())
            
    def setLog(self, log_dir):
        
        #设置日志数据的文件路径
       
        self.log_dir = log_dir
        self.fw_train = open(self.log_dir+'/train_log.txt', 'w')
            # 训练数据日志
        self.fw_test = open(self.log_dir+'/test_log.txt', 'w')
            # 测试数据日志
    def buildDocsTFIDF(self, dir):
        idf = {}
        docs = []
        docs_length1 = []
            # unigram对应的各文档有效长度
        docs_length2 = []
            # bigram对应的各文档有效长度
        for fname in os.listdir(dir):
            for line in open(os.path.join(dir, fname)):      
                docs.append({})
                doc = line.split()
                count1 = 0
                count2 = 0
                temp_set = set()
                for word in doc:
                    if word in self.dic:
                        idx = self.dic[word]          
                        count1 += 1
                        temp_set.add(idx)
                            
                        if idx not in docs[-1]:
                            docs[-1][idx] = 1         
                        else:
                            docs[-1][idx] += 1
                            
                for i in range(len(doc)-1):
                    t = tuple(doc[i:i+2])
                    if t in self.dic:
                        count2 += 1
                        idx = self.dic[t]
                        temp_set.add(idx)
                        
                        if idx not in docs[-1]:
                            docs[-1][idx] = 1
                        else:
                            docs[-1][idx] += 1   
                
                for idx in temp_set:              
                    if idx not in idf:
                        idf[idx] = 1
                    else:
                        idf[idx] += 1

                docs_length1.append(count1)                
                docs_length2.append(count2)               

        N = len(docs) + 0.0
        for idx in idf:                           
            idf[idx] = math.log(N / idf[idx])
             
        
        for i in range(len(docs)):
            doc = docs[i]
            for idx in doc:
                if idx < self.uni_count:
                    doc[idx] = doc[idx] / (docs_length1[i]+0.0) * idf[idx]  
                else:
                    doc[idx] = doc[idx] / (docs_length2[i]+0.0) * idf[idx] 
        
        #print self.dic
        #for doc in docs:
        #     print doc
        
        return docs  
    def SGD(self, iter, train_f, test_f):
        '''
        Stochastic Gradient Descent
        '''
        # train_f为训练特征，test_f为测试特征
        self.initTheta()
        # start SGD
        for j in range(iter):
            sample = random.sample(range(len(train_f)), len(train_f))
            for i in sample:
#             for i in range(len(train_f)):
                thetaX = 0
                x = train_f[i]
                for idx in x:
                    thetaX += self.theta[idx] * x[idx]
                h = self.sigmoid(thetaX)
                error = self.train_label[i] - h
                for idx in x:
                    self.theta[idx] += (x[idx] * self.alpha * error)
            print 'iter %d' %j
            print 'alpha', self.alpha
            test_acc = self.test(train_f, test_f)
#            if test_acc >= 0.903:
#                break
#             if (j+1) > 500:
#                 if 0.001 - ((j-499)/5000.0)*0.0009 > 0.0001:
#                     self.alpha = 0.001 - ((j-499)/5000.0)*0.0009
#                 else:
#                     self.alpha = 0.0001

#             if ((j+1)%1000==0):
#                 # 每1000次迭代输出一次词表
#                 print 'write word table to file...'
#                 self.writeWordTable('%s/word-%d' %(self.log_dir,(j+1)))


    def closeFw(self):
       
        self.fw_test.close()
        self.fw_train.close()   
        
    def writeGramTable(self): 
        '''
        输出词表和权重
        '''
        self.fw_grams = open(self.log_dir + '/words.txt', 'w')
        gram_weight = {}
        for g in self.dic:
            if isinstance(g, tuple):
                str =  g[0] + ' ' + g[1]
            else:
                str = g
            gram_weight[str] = self.theta[self.dic[g]]
        sort = sorted(gram_weight.items(),key=lambda e:e[1],reverse=False)
            # 按值排序
        for (gram, weight) in sort:
            self.fw_grams.write(gram)
            self.fw_grams.write('&&&&&&')
            self.fw_grams.write('%.3f' %weight)
            self.fw_grams.write('\n')           
        self.fw_grams.close()        
        
    def writeResults(self, test_f):
        '''
        输出分类结果
        '''
        self.fw_res = open(self.log_dir + '/results.txt', 'w')
        for i in range(len(test_f)):
            x = test_f[i]
            thetaX = 0
            for idx in x:
                thetaX += self.theta[idx] * x[idx]
            h = self.sigmoid(thetaX)
            y = 0
            if h > 0.5:
                y = 1
            self.fw_res.write('%d' %y)
            self.fw_res.write(' ')
            self.fw_res.write('%d' %self.test_label[i])
            self.fw_res.write(' ')
            if y == self.test_label[i]:
                self.fw_res.write('y')
            else:
                self.fw_res.write('n')
            self.fw_res.write('\n')                          
        self.fw_res.close()                                   
        
    def truncateTest(self, threshold, test_f):
        '''
        截断一些小权重的词,重新test
        '''
        correct = 0
        for i in range(len(test_f)):
            x = test_f[i]
            thetaX = 0
            for idx in x:
                if abs(self.theta[idx]) >= threshold:
                    thetaX += self.theta[idx] * x[idx]
            h = self.sigmoid(thetaX)
            y = 0
            if h > 0.5:
                y = 1
            if y == self.test_label[i]:
                correct += 1
        test_acc = correct / (len(self.test_docs) + 0.0)
        return test_acc
    
    
    def test(self, train_f, test_f):
        '''
        测试
        '''
        correct = 0
        for i in range(len(train_f)):
            x = train_f[i]
            thetaX = 0
            for idx in x:
                thetaX += self.theta[idx] * x[idx]
            h = self.sigmoid(thetaX)
            y = 0
            if h > 0.5:
                y = 1
            if y == self.train_label[i]:
                correct += 1
        train_acc = correct / (len(train_f) + 0.0)
        print '6-1 training acc', train_acc
        self.fw_train.write(str(train_acc))
        self.fw_train.write('\n')
        correct = 0
        for i in range(len(test_f)):
            x = test_f[i]
            thetaX = 0
            for idx in x:
                thetaX += self.theta[idx] * x[idx]
            h = self.sigmoid(thetaX)
            y = 0
            if h > 0.5:
                y = 1
            if y == self.test_label[i]:
                correct += 1
        test_acc = correct / (len(test_f) + 0.0)
        print '6-1 testing acc', test_acc
        print ''
        self.fw_test.write(str(test_acc))
        self.fw_test.write('\n')   
        return test_acc 
            
    def SGDwithTFIDF(self,iter):
        '''
        用TFIDF做特征的Stochastic Gradient Descent
        '''
        self.train_docs = self.buildDocsTFIDF(self.train_dir)
        print 'train TFIDF', len(self.train_docs)
        self.test_docs = self.buildDocsTFIDF(self.test_dir)
        print 'test TFIDF', len(self.test_docs)
        self.SGD(iter, self.train_docs, self.test_docs)
        self.closeFw()
        self.writeGramTable()
        self.writeResults(self.test_docs)
      #  for i in range(600):
       #     threshold = i / 600.0 * 40.0
       #     print 'truncate -threshold %f -acc %f' %(threshold, self.truncateTest(threshold, self.test_docs))

if __name__ == '__main__':
    lr = LR_Uni_Bi('.\\F1\\train', '.\\F1\\test', alpha=0.5)
    lr.buildDic(min1=0, min2=0, sw1=True, sw2=True)
    lr.getlabel()
    lr.setLog('.\\F1\\out')
    lr.SGDwithTFIDF(iter=50)
