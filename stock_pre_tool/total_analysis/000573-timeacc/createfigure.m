function createfigure(YMatrix1, EMatrix1, YMatrix2)
%CREATEFIGURE(YMATRIX1, EMATRIX1, YMATRIX2)
%  YMATRIX1:  errorbar y 矩阵
%  EMATRIX1:  errorbar e 矩阵
%  YMATRIX2:  y 数据的矩阵

%  由 MATLAB 于 24-Oct-2016 11:39:04 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1,...
    'XTickLabel',{'2','4','6','8','10','12','14','16'},...
    'FontWeight','bold',...
    'FontSize',14);
%% 取消以下行的注释以保留坐标轴的 X 范围
% xlim(axes1,[0 14]);
hold(axes1,'on');

% 创建 ylabel
ylabel('accuracy');

% 创建 xlabel
xlabel('study time k');

% 创建 title
title('stock number:000573');

% 使用 errorbar 的矩阵输入创建多个误差条
errorbar1 = errorbar(YMatrix1,EMatrix1,'LineStyle','none');
set(errorbar1(1),'Marker','x','Color',[0 0 1]);
set(errorbar1(2),'Marker','square','Color',[1 0 0]);

% 使用 plot 的矩阵输入创建多行
plot1 = plot(YMatrix2);
set(plot1(1),'Color',[1 0 0]);
set(plot1(2),'Color',[0 0.447058826684952 0.74117648601532]);

% 创建 light
light('Parent',axes1,...
    'Position',[-0.970655346734319 0.0120087455513016 0.240174911026032]);

% 创建 textbox
annotation(figure1,'textbox',...
    [0.274643410852713 0.641752577319588 0.0416356589147286 0.0773195876288659],...
    'String',{'k*=5'},...
    'FontSize',14,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% 创建 ellipse
annotation(figure1,'ellipse',...
    [0.292472868217054 0.556701030927835 0.00675193798449608 0.0231958762886597],...
    'Color',[0 0.447058826684952 0.74117648601532],...
    'FaceColor',[0 0.447058826684952 0.74117648601532]);

% 创建 textbox
annotation(figure1,'textbox',...
    [0.502550387596899 0.662371134020619 0.0524883720930235 0.121134020618557],...
    'String',{'k*=9'},...
    'FontSize',14,...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

% 创建 ellipse
annotation(figure1,'ellipse',...
    [0.513953488372092 0.824742268041237 0.00620155038759751 0.0257731958762889],...
    'Color',[1 0 0],...
    'FaceColor',[1 0 0]);

