%% Homework4
% andrew Rearson

clc;
clear all; %#ok<CLALL>
close all;
format compact

mF = @(x1,x2) 5 .* (x1).^2 + 7 .* (x2).^2 - 3 .* x1...
    - 4 .* x2 .* x1 + 2 .* x2;
syms x1 x2 x01 x02 a s1 s2
mFsyms =      5 .* (x1).^2 + 7 .* (x2).^2 - 3 .* x1...
    - 4 .* x2 .* x1 + 2 .* x2;

x1INT = [-2,2];
x2INT = [-2,2];
INT = [x1INT , x2INT];
figure(2)
fc = fcontour(mF, INT);
Pt0 = [5 2];
x1V(1,1) = Pt0(1,1);
x2V(1,1) = Pt0(1,2);
LabeLine = [0 0 2 2 4 4 6 6 10 10 15 15 20 20 25 25 50 50];
linelable = [0,2,4,6,10,20,25,50];

%% %%%%%%%%%%%%%%%%%%%%%%%%% 4.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
hold on
[M, c] = contour(fc.XData,fc.YData, fc.ZData, LabeLine, 'ShowText','on');
title(func2str(mF))
xlabel x1
ylabel x2
c.LineColor = 'black';
c.DisplayName = func2str(mF);
grid on
axis equal
legend
hold off
%%%%%%%%%%%%%%%%
g1 = @(x1, x2) 4 .* x1 + 2 .* x2;
g2 = @(x1, x2) -x2;
figure(2);
hold on
fc_g1 = fcontour(g1, INT);
g1_lim = [1 1 ... 100 100
    ];
fc_g2 = fcontour(g2, INT);
g2_lim = [-0.5 -0.5... 
    ];
hold off
figure(1) 
hold on
[M1, c1] = contour(fc_g1.XData,fc_g1.YData, fc_g1.ZData...
    , g1_lim, 'ShowText','on');
[M2, c2] = contour(fc_g2.XData,fc_g2.YData, fc_g2.ZData...
    , g2_lim,'ShowText','on');
close(2);
%%%%%%%%%%%%%%%%%%%%%
c1.DisplayName = "g1";
c2.DisplayName = "g2";
c1.LineColor = "#77AC30";
c2.LineColor = "#77AC30";
c1.LineWidth = 2;
c2.LineWidth = 2;
saveas(1, 'HW4_contour_noFILL.png');
c1.Fill = 'on';
c2.Fill = "on";
saveas(1, 'HW4_contour_FILLon.png');
close(1)

%% %%%%%%%%%%%%%%%%%%%%%%%%%% 4.2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3)
plot(peaks)
% subplot(1,2)







