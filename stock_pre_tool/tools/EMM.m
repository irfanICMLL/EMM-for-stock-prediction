function [acc] = EMM(VarName5,time,node,epochs,mood_series)
%%%%%%%%%% VarName5为对应的股票价格，time为历史时间窗长度，node为神经网络的隐含层节点数
price=VarName5;%%股票价格
fudu=bodong(price);
mood_series=zscore(mood_series);
[mood_series]=guiyihua(mood_series);
[fudu]=p_guiyihua(fudu);
time_series=[mood_series(2:end,:),fudu];%%金融时间序列
%% MOOD WITH PRICE
%%%%%初始化%%%%%%%%
shuju=time_series;
count=length(shuju);
%%%%%%%%%%变为time维度输入%%%%%%
input=shuju(1:count-time+1,:);
for i=2:time
    temp=shuju(i:count-time+i,:);
    input=[input,temp];
end
input=input(1:count-time,:);
output=shuju(time+1:count,3);
% EXACT DATA.
trainX=input(1:fix(0.9*count),:);
trainY=output(1:fix(0.9*count),:);
testX=input(fix(0.9*count)+1:count-time,:);
testY=output(fix(0.9*count)+1:count-time,:);
factors=1;
net=newelm(minmax(trainX'),[node,1],{'tansig','tansig'});%建立网络模型，其中参数可以根据要求修改
net.trainparam.show=100;%每迭代100次显示1次
net.trainparam.epochs=epochs;%最大迭代次数2000
net.trainparam.goal=0.0001;%迭代目标
net=init(net);%初始化网络
[net,tr]=train(net,trainX',trainY');%训练网络

% net=newff(minmax(trainX'),[node factors],{'logsig','logsig'},'traingdx','learngdm');
% 
% %%设置训练参数
% net.trainFcn='trainlm';
% net.trainparam.show=50;
% net.trainparam.epochs=epochs;
% net.trainparam.goal=0.000003;
% net.trainparam.lr=0.02;
% %开始训练
% net=train(net,trainX',trainY');
%%仿真
y=sim(net,testX');
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