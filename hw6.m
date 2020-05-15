%% Homework6
% andrew Rearson

clc;
clear all; %#ok<CLALL>
close all;
format compact


mF = @(x1,x2) -1*x1 / 2 - 3 * x2 / 2;
% syms x1 x2 x01 x02 a s1 s2
% mFsyms =      5 .* (x1).^2 + 7 .* (x2).^2 - 3 .* x1...
%     - 4 .* x2 .* x1 + 2 .* x2;

x1INT = [2.5,6.5];
x2INT = [0,5.5];
INT = [x1INT , x2INT];
fig_given = figure('Name',"GivenInfo_6",'NumberTitle','off');
fig_temp = figure('Name',"Temp",'NumberTitle','off');
figure(fig_temp)
fc = fcontour(mF, INT);

% Pt0 = [5 2];
% x1V(1,1) = Pt0(1,1);
% x2V(1,1) = Pt0(1,2);
LabeLine = [0 0 -1 -1 -2 -2 -3 -3 -4 -4 -5 -5 -6 -6 -7 -7 -8 -8 -9 -9 -10 -10 -10 -11 -11 -12 -12 -13 -13 -14 -14];
% linelable = [0,2,4,6,10,20,25,50];

%% %%%%%%%%%%%%%%%%%%%%%%%%% 4.1 Graphs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_given);
hold on
title(func2str(mF))
xlabel x1
ylabel x2
[M, c] = contour(fc.XData,fc.YData, fc.ZData,LabeLine, ...20 ,...
    'ShowText','on');
c.LineColor = 'black';
c.DisplayName = func2str(mF);
grid on
axis equal
legend
hold off

%%%%%%%%%%%%%%%%

% g1 = @(x1, x2) 6/x1 - 5/x2 - 1;
g1 = @(x1, x2) 6*x2-5*x1-x2*x1;
g2 = @(x1, x2) x1 + x2 - 8;
% g3 = @(x1, x2) -2*x1+x2-2;
figure(fig_temp) %%%%%%%%%

hold on
fc_g1 = fcontour(g1, INT);
g1_lim = [0 0  ... 100 100
    ];
fc_g2 = fcontour(g2, INT);
g2_lim = [0 0 ... 
    ];
% fc_g3 = fcontour(g3, INT);
% g3_lim = [0 0 ... 
%     ];
hold off

%%%%%%%%%%%%%%%%%

figure(fig_given)
hold on
[M1, c1] = contour(fc_g1.XData,fc_g1.YData, fc_g1.ZData ...
    , g1_lim, 'ShowText','on');
[M2, c2] = contour(fc_g2.XData,fc_g2.YData, fc_g2.ZData ...
    , g2_lim,'ShowText','on');
% [M3, c3] = contour(fc_g3.XData,fc_g3.YData, fc_g3.ZData ...
%     , g3_lim,'ShowText','on');
%%%%%%%%%%%%%%%%%%%%%
figure(fig_given);
c1.DisplayName = "g1 = 0";
c2.DisplayName = "g2 = 0";
% c3.DisplayName = "g3 = 0";
c1.LineColor = "#77AC30";
c2.LineColor = "b";
% c3.LineColor = "k";
c1.LineWidth = 2;
c2.LineWidth = 2;
% c3.LineWidth = 2;
saveas(fig_given, 'HW6_contour_noFILL.png');
c1.Fill = 'on';
c2.Fill = "on";
% c3.Fill = "on";
saveas(fig_given, 'HW6_contour_FILLon.png');
% close(1)

point1_1= 5.5;
point1_2= 1.5;
point2_1= 6;
point2_2= 2;
point3_1= 5.5;
point3_2= 2.5;

plot(point1_1,point1_2,'Marker','.','DisplayName',...
        sprintf('Iteration #%i @ %.3g,%.3g',1,point1_1,point1_2),...
        'MarkerSize',20,'Color','red');
plot(point2_1,point2_2,'Marker','.','DisplayName',...
        sprintf('Iteration #%i @ %.3g,%.3g',2,point2_1,point2_2),...
        'MarkerSize',20,'Color','blue');
plot(point3_1,point3_2,'Marker','.','DisplayName',...
        sprintf('Iteration #%i @ %.3g,%.3g',3,point3_1,point3_2),...
        'MarkerSize',20,'Color','green');
saveas(fig_given, 'HW6_2.png');
    
point1_1= 5.5;
point1_2= 1.423;
point2_1= 5.435;
point2_2= 1.923;
point3_1= 5.069;
point3_2= 2.423;

plot(point1_1,point1_2,'Marker','o','DisplayName',...
        sprintf('Iteration #%i @ %.3g,%.3g',1,point1_1,point1_2),...
        'MarkerSize',10,'Color','red');
plot(point2_1,point2_2,'Marker','o','DisplayName',...
        sprintf('Iteration #%i @ %.3g,%.3g',2,point2_1,point2_2),...
        'MarkerSize',10,'Color','blue');
plot(point3_1,point3_2,'Marker','o','DisplayName',...
        sprintf('Iteration #%i @ %.3g,%.3g',3,point3_1,point3_2),...
        'MarkerSize',10,'Color','green');

    saveas(fig_given, 'HW6_3.png');
point1_1= 5;
point1_2= 1;
point2_1= 6;
point2_2= 2;
point3_1= 3;
point3_2= 5;


plot(point1_1,point1_2,'Marker','*','DisplayName',...
        sprintf('Iteration #%i @ %.3g,%.3g',1,point1_1,point1_2),...
        'MarkerSize',20,'Color','red');
plot(point2_1,point2_2,'Marker','*','DisplayName',...
        sprintf('Iteration #%i @ %.3g,%.3g',2,point2_1,point2_2),...
        'MarkerSize',20,'Color','blue');
plot(point3_1,point3_2,'Marker','*','DisplayName',...
        sprintf('Iteration #%i @ %.3g,%.3g',3,point3_1,point3_2),...
        'MarkerSize',20,'Color','green');
saveas(fig_given, 'HW6_4.png');