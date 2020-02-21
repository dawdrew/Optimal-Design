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
hold on
[M, c] = contour(fc.XData,fc.YData, fc.ZData, LabeLine, 'ShowText','on');
title(func2str(mF))
xlabel x1
ylabel x2
c.LineColor = 'black';
grid on
axis equal

legend on
% close(1);


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
SD = double(VALS);
StD = plot(SD(:,2),SD(:,3));

f(j+1,1) = double(subs(mFsyms, [x1, x2], [x1V(j+1,1), x2V(j+1,1)]));
double([f(j+1,1), x1V(j+1,1), x2V(j+1,1)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% fletcher Reeves 

% iteration is just S.D.

answ = [subs(s1_EQ, [x1 x2],[x1V(2,1) x2V(2,1)]) ,subs(s2_EQ, [x1 x2],[x1V(2,1) x2V(2,1)]), ...
        subs(s1_EQ, [x1 x2],[x1V(1,1) x2V(1,1)]) ,subs(s2_EQ, [x1 x2],[x1V(1,1) x2V(1,1)])];
b = double((answ(1)^2+answ(2)^2)/(answ(3)^2+answ(4)^2));
sn1 = -(answ(1))+b*answ(3);
sn2 = -(answ(2))+b*answ(4);
SN = double([sn1,sn2]);


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
        [x1V(2,1) x2V(2,1), SN(1), SN(2)]));


xn = double([x1V(2,1) x2V(2,1)] + aplf .* SN);
funct = subs(mFsyms,[x1,x2],[xn]);
double([subs(s1_EQ, [x1 x2],xn), subs(s2_EQ, [x1 x2],xn)]);

% iteration 2

answ = [subs(s1_EQ, [x1 x2],xn) ,                 subs(s2_EQ, [x1 x2],xn), ...
        subs(s1_EQ, [x1 x2],[x1V(2,1) x2V(2,1)]) ,subs(s2_EQ, [x1 x2],[x1V(2,1) x2V(2,1)])];
b(2,:) = double((answ(1)^2+answ(2)^2)/(answ(3)^2+answ(4)^2));

sn1 = -(answ(1))+b*answ(3);
sn2 = -(answ(2))+b*answ(4);
SN(2,:) = double([sn1(2), sn2(2)]);


aplf(2) = double(subs(alpha, [x01 x02 s1 s2], ...
        [xn(1,1), xn(1,2), SN(2,1), SN(2,2)]));

xn(2,:) = double(xn + aplf(2) .* SN(2,:));
funct(2,:) = subs(mFsyms,[x1,x2],[xn(2,:)]);
double([subs(s1_EQ, [x1 x2], xn(2,:)), subs(s2_EQ, [x1 x2],xn(2,:))]);


% iteration 3

answ = [subs(s1_EQ, [x1 x2],xn(2,:)) ,subs(s2_EQ, [x1 x2],xn(2,:)), ...
        subs(s1_EQ, [x1 x2],xn(1,:)) ,subs(s2_EQ, [x1 x2],xn(1,:))];
b(3,:) = double((answ(1)^2+answ(2)^2)/(answ(3)^2+answ(4)^2));

sn1 = -(answ(1))+b*answ(3);
sn2 = -(answ(2))+b*answ(4);
SN(3,:) = double([sn1(3), sn2(3)]);


aplf(3) = double(subs(alpha, [x01 x02 s1 s2], ...
        [xn(2,1), xn(2,2), SN(3,1), SN(3,2)]));

xn(3,:) = double(xn(1,:) + aplf(3) .* SN(3,:));
funct(3,:) = subs(mFsyms,[x1,x2], xn(3,:));
double([subs(s1_EQ, [x1 x2], xn(3,:)), subs(s2_EQ, [x1 x2],xn(3,:))]);

FR = double([funct,xn,aplf.',SN]);
FRplt = plot(xn(:,1),xn(:,2));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DFP-m
% SD is first iteration 
xn = [x1V(1,1) , x2V(2,1); x2V(1,1), x1V(2,1)];
% first iteration of DFP-m

HES = eye(2);

% D = 1/ sig .* P .* p.' - 1/tau .* HES * y .* (H * y).'
% H1 = H0 + D
for j=1:3
p(:,j) = xn(:,j+1)-xn(:,j) ;
y(:,j) = double([subs(s1_EQ, [x1 x2],[xn(1,j+1),xn(2,j+1)]); subs(s2_EQ, [x1 x2],[xn(1,j+1),xn(2,j+1)])]...
               -[subs(s1_EQ, [x1 x2],[xn(1,j),  xn(2,j)]);   subs(s2_EQ, [x1 x2],[xn(1,j),  xn(2,j)])]);
sig(:,j) = p(:,j).' * y(:,j);
tau(:,j) = y(:,j).' * HES * y(:,j);
D = 1/ sig(:,j) * p(:,j) * p(:,j).' - 1/tau(:,j) * HES * y(:,j) * (HES * y(:,j)).';
HES = HES + D;
Sn(:,j) = HES * double([subs(s1_EQ, [x1 x2],[xn(1,j), xn(2,j)]); subs(s2_EQ, [x1 x2],[xn(1,j), xn(2,j)])]);
alph(:,j) = double(subs(alpha, [x01 x02 s1 s2], ...
        [xn(1,j+1), xn(2,j+1), Sn(1,j), Sn(2,j)]));
xn(:,j+2) = xn(:,j+1) + alph(:,j) .* Sn(:,j);


end
xn = xn.'
DFP = plot(xn(:,1),xn(:,2)); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BFGS
% SD is first iteration 
xn = [x1V(1,1) , x2V(2,1); x2V(1,1), x1V(2,1)];
% first iteration of DFP-m

HES = eye(2);

% D = 1/ sig .* P .* p.' - 1/tau .* HES * y .* (H * y).'
% H1 = H0 + D
for j=1:3
p(:,j) = xn(:,j+1)-xn(:,j);
y(:,j) = double([subs(s1_EQ, [x1 x2],[xn(1,j+1),xn(2,j+1)]); subs(s2_EQ, [x1 x2],[xn(1,j+1),xn(2,j+1)])]...
               -[subs(s1_EQ, [x1 x2],[xn(1,j),  xn(2,j)]);   subs(s2_EQ, [x1 x2],[xn(1,j),  xn(2,j)])]);
sig(:,j) = p(:,j).' * y(:,j);
tau(:,j) = y(:,j).' * HES * y(:,j);
D = (sig(:,j)+tau(:,j)) / (sig(:,j))^2 * p(:,j) * p(:,j).' ...
    - 1/sig(:,j)*(HES*y(:,j)*p(:,j).' + p(:,j)*(HES*y(:,j)).');
HES = HES + D;
Sn(:,j) = HES * double([subs(s1_EQ, [x1 x2],[xn(1,j), xn(2,j)]); subs(s2_EQ, [x1 x2],[xn(1,j), xn(2,j)])]);
alph(:,j) = double(subs(alpha, [x01 x02 s1 s2], ...
        [xn(1,j+1), xn(2,j+1), Sn(1,j), Sn(2,j)]));
xn(:,j+2) = xn(:,j+1) + alph(:,j) .* Sn(:,j);

end
xn
BFGS = plot(xn(1,:),xn(2,:));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% powels Conj Dir
AL = 100;

j = 1;
X0  = [5;2];
SD2 = [0;1];
SD1 = [1;0];

while  AL~=0
AL = double(subs(alpha, [x01 x02 s1 s2], ...
        [X0(1,1) X0(2,1), SD1(1,1), SD1(2,1)]));
    
X1 = X0 + AL .* SD1;


AL = double(subs(alpha, [x01 x02 s1 s2], ...
        [X1(1,1) X1(2,1), SD2(1,1), SD2(2,1)]));


X2 = X1 + AL .* SD2;

SC = X2 - X0;

AL = double(subs(alpha, [x01 x02 s1 s2], ...
        [X2(1,1) X2(2,1), SC(1,1), SC(2,1)]));

    
SAVESTATE(j:j+1,:) = [X0, X1, X2, SD1, SD2, SC];
j=j+2;
X0 = X1;
X1 = X2;
X2 = X2 + AL * SC;

SD1 = SD2;
SD2 = SC;

end
for i = 1:17
x2PLT(i,:) = [SAVESTATE(i+i-1,3),SAVESTATE(i+i,3)];
end
POW = plot(x2PLT(:,1),x2PLT(:,2));
SAVESTATE;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NEWTON

DX = diff(mFsyms, x1);
DY = diff(mFsyms, x2);
DXX = diff(DX,x1);
DXY = diff(DX,x2);
DYY = diff(DY,x2);
DYX = diff(DY,x1);
H = [DXX,DXY;...
    DYX,DYY];

S = inv(H);
delF = [DX; DY];
x = 5;
y = 2;
loc = [x;y];

for j = 1:3
loc(:,j+1) = loc(:,j)- subs(S, [x1,x2],[loc(1,j),loc(2,j)]) *...
            subs(delF,[x1,x2],[loc(1,j),loc(2,j)]);

end
loc
NEWTON = plot(loc(:,1),loc(:,2));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3.8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Graphing

LVals = [StD, POW, BFGS, DFP, FRplt, NEWTON]; ... ,  , 


legend("location", "northwest")
legend(LVals, 'Steepest', 'Powels', 'BFGS', 'DFP', 'Fletcher', 'Newton^s')


hold off

saveas(1, 'HW3_contour.png');





