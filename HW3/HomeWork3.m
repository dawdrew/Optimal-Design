%% Home Work #3

mainFunction = @(x1,x2) 5 .* x1.^2 + 7 .* x2.^2 - 5 .* x1 - 10 .* x2 .* x1 + x2;

x1INT = [-2,6];
x2INT = [-1,4];
INT = [x1INT , x2INT];
fcontour(mainFunction, INT);
zhandle.LevelList = 1;
xlabel x1
ylabel x2
title(func2str(mainFunction))
grid on
axis equal