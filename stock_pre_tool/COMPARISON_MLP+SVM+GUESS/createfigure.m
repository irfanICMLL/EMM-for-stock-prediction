function createfigure(yvector1, E1)
%CREATEFIGURE(YVECTOR1, E1)
%  YVECTOR1:  bar yvector
%  E1:  errorbar e

%  由 MATLAB 于 08-Nov-2016 23:57:27 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1,'XTickLabel',{'RAND','MLP','SVM','RNN'},...
    'XTick',[1 2 3 4],...
    'FontWeight','bold',...
    'FontSize',16);
%% 取消以下行的注释以保留坐标轴的 Y 范围
% ylim(axes1,[0.4 0.8]);
box(axes1,'on');
hold(axes1,'on');

% 创建 ylabel
ylabel('accuracy');

% 创建 bar
bar(yvector1,'FaceColor',[1 1 1],'BarWidth',1);
end


