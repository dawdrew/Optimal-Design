%% Home Work #3

mainFunction = @(x1,x2) 5 .* x1.^2 + 7 .* x2.^2 - 5 .* x1 - 10 .* x2 .* x1 + x2;

x1INT = [-2,6];
x2INT = [-1,4];
INT = [x1INT , x2INT];
fc = fcontour(mainFunction, INT);
% zhandle.LevelList = 1;
% xlabel x1
% ylabel x2
% title(func2str(mainFunction))
% grid on
% axis equal
LabeLine = [-3 -3 0 0 5 5 10 10 20 20 30 30 50 50 100 100];
% fc.LevelList = LabeLine;

figure(1)
% contour(fc.XData,fc.YData, fc.ZData, 'ShowText','on');
[M, c] = contour(fc.XData,fc.YData, fc.ZData, LabeLine, 'ShowText','on');
title(func2str(mainFunction))
xlabel x1
ylabel x2
c.LineColor = 'black';