%% Homework5
% andrew Rearson

clc;
clear all; %#ok<CLALL>
close all;
format compact


mF = @(x1,x2) 3*x1-x2;
% syms x1 x2 x01 x02 a s1 s2
% mFsyms =      5 .* (x1).^2 + 7 .* (x2).^2 - 3 .* x1...
%     - 4 .* x2 .* x1 + 2 .* x2;

x1INT = [0,5];
x2INT = [0,5];
INT = [x1INT , x2INT];
fig_given = figure('Name',"GivenInfo_5.3",'NumberTitle','off');
fig_temp = figure('Name',"Temp",'NumberTitle','off');
figure(fig_temp)
fc = fcontour(mF, INT);

Pt0 = [5 2];
x1V(1,1) = Pt0(1,1);
x2V(1,1) = Pt0(1,2);
LabeLine = [0 0 2 2 4 4 6 6 10 10 15 15 20 20 25 25 50 50];
% linelable = [0,2,4,6,10,20,25,50];

%% %%%%%%%%%%%%%%%%%%%%%%%%% 4.1 Graphs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_given);
hold on
title(func2str(mF))
xlabel x1
ylabel x2
[M, c] = contour(fc.XData,fc.YData, fc.ZData,100,... 
    'ShowText','on');
c.LineColor = 'black';
c.DisplayName = func2str(mF);
grid on
axis equal
legend
hold off

%%%%%%%%%%%%%%%%

g1 = @(x1, x2) -4*x1+x2-.5;
g2 = @(x1, x2) x1+x2-6;
g3 = @(x1, x2) -3*x1+x2+1;
figure(fig_temp) %%%%%%%%%

hold on
fc_g1 = fcontour(g1, INT);
g1_lim = [0 0  ... 100 100
    ];
fc_g2 = fcontour(g2, INT);
g2_lim = [0 0 ... 
    ];
fc_g3 = fcontour(g3, INT);
g3_lim = [0 0 ... 
    ];
hold off

%%%%%%%%%%%%%%%%%

figure(fig_given)
hold on
[M1, c1] = contour(fc_g1.XData,fc_g1.YData, fc_g1.ZData ...
    , g1_lim, 'ShowText','on');
[M2, c2] = contour(fc_g2.XData,fc_g2.YData, fc_g2.ZData ...
    , g2_lim,'ShowText','on');
[M3, c3] = contour(fc_g3.XData,fc_g3.YData, fc_g3.ZData ...
    , g3_lim,'ShowText','on');
%%%%%%%%%%%%%%%%%%%%%
figure(fig_given);
c1.DisplayName = "g1 = 0";
c2.DisplayName = "g2 = 0";
c3.DisplayName = "g3 = 0";
c1.LineColor = "#77AC30";
c2.LineColor = "b";
c3.LineColor = "k";
c1.LineWidth = 2;
c2.LineWidth = 2;
c3.LineWidth = 2;
saveas(fig_given, 'HW5-3_contour_noFILL.png');
c1.Fill = 'on';
c2.Fill = "on";
c3.Fill = "on";
saveas(fig_given, 'HW5-3_contour_FILLon.png');
% close(1)