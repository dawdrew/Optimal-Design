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
x1V(1,1) = Pt0(1,1);
x2V(1,1) = Pt0(1,2);
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


diffeqA = diff(eqn,a);
alpha = solve(diffeqA,a);

s1_EQ = diff(mFsyms, x1);
s2_EQ = diff(mFsyms, x2);

s1V(1,1) = subs(diff(mFsyms,x1), [x1 x2], [x1V, x2V]);
s2V(1,1) = subs(diff(mFsyms,x2), [x1 x2], [x1V, x2V]);
a(1,1) = subs(alpha, [x01 x02 s1 s2], [x1V x2V s1V s2V]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Steepest Descent
% iterations 1:3
for j=1:3
        
    s1V(j,1) = subs(diff(mFsyms,x1), [x1 x2], [x1V(j,1), x2V(j,1)]);
    s2V(j,1) = subs(diff(mFsyms,x2), [x1 x2], [x1V(j,1), x2V(j,1)]);
    a(j,1) = subs(alpha, [x01 x02 s1 s2], ...
        [x1V(j,1) x2V(j,1) s1V(j,1) s2V(j,1)]);
    f(j,1) = subs(mFsyms, [x1, x2], [x1V(j,1) x2V(j,1)]);
    %save
    VALS(j,:) = [f(j) x1V(j,1) x2V(j,1) a(j,1) s1V(j,1) s2V(j,1)];

    % get next x's
    answ = [x1V(j,1), x2V(j,1)] + a(j,1) .* [s1V(j,1), s2V(j,1)];
    x1V(j+1,1) = answ(1);
    x2V(j+1,1) = answ(2);
end 

% FIN
SD = double(VALS)

f(j+1,1) = double(subs(mFsyms, [x1, x2], [x1V(j+1,1), x2V(j+1,1)]));
double([f(j+1,1), x1V(j+1,1), x2V(j+1,1)])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% fletcher Reeves 

% iteration is just S.D.

answ = [subs(s1_EQ, [x1 x2],[x1V(2,1) x2V(2,1)]) ,subs(s2_EQ, [x1 x2],[x1V(2,1) x2V(2,1)]), ...
        subs(s1_EQ, [x1 x2],[x1V(1,1) x2V(1,1)]) ,subs(s2_EQ, [x1 x2],[x1V(1,1) x2V(1,1)])];
b = double((answ(1)^2+answ(2)^2)/(answ(3)^2+answ(4)^2))
sn1 = -(answ(1))+b*answ(3);
sn2 = -(answ(2))+b*answ(4);
SN = double([sn1,sn2])


% %%%%%% 1-d set ip-- not sure how to do this part
% Dalph1 = functionsHW2(.001,[1/SN(1) -x1V(2,1)], [1.5,0] ,x1INT);
% Dalph2 = functionsHW2(.001,[1/SN(2) -x2V(2,1)], [2,  0] ,x2INT);
% 
% if Dalph1.GoldenSec.gsRes(end,1)>Dalph2.GoldenSec.gsRes(end,1)
% %     Dalph1.GoldenSec.gsRes
%     aplf = Dalph1.GoldenSec.gsRes(end,1)
% else
% %     Dalph2.GoldenSec.gsRes
%     aplf = Dalph2.GoldenSec.gsRes(end,1)
% end
% 
% %%%%% end 1 D solve for alpha
aplf = double(subs(alpha, [x01 x02 s1 s2], ...
        [x1V(2,1) x2V(2,1), SN(1), SN(2)]))


xn = double([x1V(2,1) x2V(2,1)] + aplf .* SN)
double([subs(s1_EQ, [x1 x2],xn), subs(s2_EQ, [x1 x2],xn)])

% iteration 2

answ = [subs(s1_EQ, [x1 x2],xn) ,                 subs(s2_EQ, [x1 x2],xn), ...
        subs(s1_EQ, [x1 x2],[x1V(2,1) x2V(2,1)]) ,subs(s2_EQ, [x1 x2],[x1V(2,1) x2V(2,1)])];
b(2,:) = double((answ(1)^2+answ(2)^2)/(answ(3)^2+answ(4)^2));

sn1 = -(answ(1))+b*answ(3);
sn2 = -(answ(2))+b*answ(4);
SN(2,:) = double([sn1(2), sn2(2)])


aplf = double(subs(alpha, [x01 x02 s1 s2], ...
        [xn(1,1), xn(1,2), SN(2,1), SN(2,2)]))
































