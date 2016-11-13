function [acc] = BPnet(VarName5,time,node,epochs )
%%%%%%%%%%VarName1 为股票的开盘时间 VarName5为对应的股票价格，time为历史时间窗长度，node为神经网络的隐含层节点数
price=VarName5;%%股票价格
fudu=bodong(price);
%% ONLY WITH PRICE
%%%%%初始化%%%%%%%%
shuju=fudu;
[count,factors]=size(shuju);
[shuju]=p_guiyihua(shuju);
%%%%%%%%%%变为time维度输入%%%%%%
input=shuju(1:count-time+1,:);
for i=2:time
    temp=shuju(i:count-time+i,:);
    input=[input,temp];
end
input=input(1:count-time,:);
output=shuju(time+1:count,1);
% EXACT DATA
trainX=input(1:fix(0.9*count),:);
trainY=output(1:fix(0.9*count),:);
testX=input(fix(0.9*count)+1:count-time,:);
testY=output(fix(0.9*count)+1:count-time,:);
factors=1;

net=newff(minmax(trainX'),[node factors],{'logsig','logsig'},'traingdx','learngdm');

%%设置训练参数
net.trainFcn='trainlm';
net.trainparam.show=50;
net.trainparam.epochs=epochs;
net.trainparam.goal=0.000003;
net.trainparam.lr=0.02;
%开始训练
net=train(net,trainX',trainY');
%%仿真
y=sim(net,testX');
[s1 s2]=size(y);
temp=y;
y(find(y>0.5))=1;
y(find(y<=0.5))=0;
testY(find(testY>0.5))=1;
testY(find(testY<=0.5))=0;
%%
right=zeros(length(y),1);
for i=1:length(y)
    if testY(i)==y(i)
        right(i)=1;
    end
end
disp(' ');
acc=sum(right)/length(y);


end

