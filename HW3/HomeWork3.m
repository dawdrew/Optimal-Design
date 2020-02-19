%% Home Work #3

mF = @(x1,x2) 5 .* x1.^2 + 7 .* x2.^2 - 5 .* x1 - 10 .* x2 .* x1 + x2;

x1INT = [-2,6];
x2INT = [-1,4];
INT = [x1INT , x2INT];
fc = fcontour(mF, INT);

LabeLine = [-3 -3 0 0 5 5 10 10 20 20 30 30 50 50 100 100];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
[M, c] = contour(fc.XData,fc.YData, fc.ZData, LabeLine, 'ShowText','on');
title(func2str(mF))
xlabel x1
ylabel x2
c.LineColor = 'black';
grid on
axis equal
saveas(1, 'HW3_contour.png')
