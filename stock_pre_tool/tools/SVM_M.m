function [acc] =SVM_M(price,mood_s,time)
%% ONLY WITH PRICE
%%%%%初始化%%%%%%%%
fudu=bodong(price);
output=updown(price)';
time_series=[mood_s(2:end,:),fudu];
shuju=time_series;
[count,factors]=size(shuju);
[shuju]=guiyihua(shuju);
%%%%%%%%%%变为time维度输入%%%%%%
input=shuju(1:count-time+1,:);
for i=2:time
    temp=shuju(i:count-time+i,:);
    input=[input,temp];
end
input=input(1:count-time,:);
output=output(time+1:count,1);
% EXACT DATA
trainX=input(1:fix(0.9*count),:);
trainY=output(1:fix(0.9*count),:);
testX=input(fix(0.9*count)+1:count-time,:);
testY=output(fix(0.9*count)+1:count-time,:);

model=svmtrain(trainY,trainX);
[predict_label, Accuracy, dec_values] =svmpredict(testY,testX,model);
acc=Accuracy(1,1);
end

