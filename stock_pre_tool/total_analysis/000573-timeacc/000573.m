load 000573mood.mat

%% %%看涨指数的计算%%
[mood_s]=mood_c(date_m,date_s,opinion);
characteristic=[price,mood_s];
char_choose3=characteristic;
%%对比试验
accb=cell(13,4);
for time=7:15
accem=zeros(50,1);
accep=zeros(50,1);
for i=1:50
[em] = EMM(char_choose3(:,1),time,20,2000,char_choose3(:,2:3));
accem(i)=em;
[ep] = RNN(char_choose3(:,1),time,20,2000);
accep(i)=ep;
end

acc_em=sum(accem)/50;
acc_ep=sum(accep)/50;
accb{time-2,1}=accem;
accb{time-2,2}=acc_em;
accb{time-2,3}=accep;
accb{time-2,4}=acc_ep;
end
for i=1:5
    for j=1:4
    accb{i,j}=acc{i,j};
end
end



