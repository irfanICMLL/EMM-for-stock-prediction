load 000573data.mat%%%% stock number

%% %%bullishness%%
[mood_s]=mood_c(date_m,date_s,opinion);
characteristic=[price,mood_s];
char_choose3=characteristic;
%% comparison study
acc=cell(13,4);
for time=3:15
accem=zeros(50,1);
accep=zeros(50,1);
for i=1:50
[em] = ENN(char_choose3(:,1),time,20,2000,char_choose3(:,2:3));
accem(i)=em;
[ep] = RNN(char_choose3(:,1),time,20,2000);
accep(i)=ep;
end

acc_em=sum(accem)/50;%%acc FOR emm+rnn
acc_ep=sum(accep)/50;%%acc FOR rnn
acc{time-2,1}=accem;
acc{time-2,2}=acc_em;
acc{time-2,3}=accep;
acc{time-2,4}=acc_ep;
end



