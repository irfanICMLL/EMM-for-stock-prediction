function draw_r(YMatrix1)
%CREATEFIGURE(YMATRIX1)
%  YMATRIX1:  y 数据矩阵

%  由 MATLAB 于 23-Oct-2016 00:00:44 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1,...
    'XTickLabel',['Aug 19th';'Aug 22th';'Aug 23th';'Aug 24th';'Aug 25th';'Aug 26th';'Aug 29th';'Aug 30th';'Aug 31th';'Sep 1st ';'Sep 2nd ';'Sep 5th ';'Sep 6th ';'Sep 7th ';'Sep 8th '],...
    'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]);
%% 取消以下行的注释以保留坐标轴的 X 范围
% xlim(axes1,[1 16]);
box(axes1,'on');
hold(axes1,'on');

% 创建 ylabel
ylabel('notmaization value');

% 创建 xlabel
xlabel('2016');

% 创建 title
title('Relationship Between Number of Comments and the Absolute Value of Volatility');

% 使用 plot 的矩阵输入创建多行
plot1 = plot(YMatrix1);
set(plot1(1),'DisplayName','Number of Comments','Color',[1 0 0]);
set(plot1(2),'DisplayName','Absolute Value of Volatility','Color',[0 0 1]);

% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,'FontSize',9);

