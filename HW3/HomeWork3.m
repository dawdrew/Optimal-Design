%% Home Work #3
clc;
clear all;
format compact

mF = @(x1,x2) 5 .* x1.^2 + 7 .* x2.^2 - 5 .* x1 - 10 .* x2 .* x1 + x2;
syms x1 x2 x01 x02 a s1 s2
mFsyms = 5 .* (x1).^2 + 7 .* (x2).^2 - 5 .* x1 - 10 .* x2 .* x1 + x2;

x1INT = [-2,6];
x2INT = [-1,4];
INT = [x1INT , x2INT];
fc = fcontour(mF, INT);
Pt0 = [5 2];
x1V = Pt0(1,1);
x2V = Pt0(1,2);
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
saveas(1, 'HW3_contour.png');
close(1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eqn = 5 *(x01+a*s1)^2 + 7 * (x02+a*s2)^2 ...
       -5*(x01+a*s1) - 10*((x01+a*s1)*(x02+a*s2)) ...
        + (x02+a*s2);
    
checkEQN = subs(mFsyms, [x1 x2], [x01+a*s1, x02+a*s2]);


diffeqA = diff(eqn,a)
alpha = solve(diffeqA,a)

s1_EQ = diff(mFsyms, x1)
s2_EQ = diff(mFsyms, x2)

s1V = subs(diff(mFsyms,x1), [x1 x2], [x1V, x2V])
s2V = subs(diff(mFsyms,x2), [x1 x2], [x1V, x2V])

a = subs(alpha, [x01 x02 s1 s2], [x1V x2V s1V s2V])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





