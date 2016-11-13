for sheet=1:10
[NUM]=xlsread('stock_price',sheet,'B1:B230');
%% %%数据导入及命名
% date_m=
% date_s=
% opinion=
price=NUM;
stock_series=[price];
char_choose=[stock_series(:,1)];
%% test with time 
acc_s=cell(13,3);
for time=3:15      %%%训练时间窗长度
%% BPnet with price
sum1=0;
count=50       %%%%测试次数
node=20          %%%隐含层节点数
acc1=zeros(count,1);
for i=1:count
[p] = BPnet(char_choose(:,1),time,node,2000);
acc1(i)=p;
acc_p_BP=sum(acc1)/count;
end
acc_s{time-2,1}=acc1;
acc_s{time-2,2}=acc_p_BP;
%%%%%SVM with price
[acc_svm] =SVM_P(char_choose(:,1),time);
acc_s{time-2,3}=acc_svm;
end
name=['a','b','c','d','e','f','g','h','i','j'];
save(name(sheet));
clear;
end
