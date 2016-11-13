for i=1:13
    m(i)=acc{i,2};
    p(i)=acc{i,4};
end
      mc=acc{1,1};
      pc=acc{1,3};
for i=2:13
    mc=[mc,acc{i,1}];
    pc=[pc,acc{i,3}];  
end


plot(p);
hold on;
plot(m);
hold on;

py = mean(pc);
pe = std(pc);
errorbar(py,pe,'xb');
hold on;
y = mean(mc);
e = std(mc);
errorbar(y,e,'xr')
hold on;
legend('RNN','EMM+RNN');

% ´´½¨ legend
legend1 = legend(axes1,'show');
set(legend1,'FontSize',9);