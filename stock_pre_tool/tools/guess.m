acc_g=cell(13,10);
for sheet=1:10
[NUM]=xlsread('stock_price',sheet,'B1:B230');
char_choose=NUM;
%% test with time 
for time=3:15      %%%训练时间窗长度
%% BPnet with price
sum1=0;
count=50;      %%%%测试次数      %%%隐含层节点数
acc1=zeros(count,1);
fudu=bodong(char_choose);
%% ONLY WITH PRICE
for truns=1:count
%%%%%初始化%%%%%%%%
shuju=fudu;
n=length(shuju);
[shuju]=p_guiyihua(shuju);
output=shuju(time+1:n,1);
testY=output(fix(0.85*n)+1:n-time,:);
y=rand(length(testY),1);
y(find(y>0.5))=1;
y(find(y<=0.5))=0;
testY(find(testY>0.5))=1;
testY(find(testY<=0.5))=0;
right=zeros(length(y),1);
for i=1:length(y)
    if testY(i)==y(i)
        right(i)=1;
    end
end
p=sum(right)/length(y);
acc1(truns)=p;
end
acc_g{time-2,sheet}=acc1;
acc_g_a(time-2,sheet)=sum(acc1)/50;
end
end

