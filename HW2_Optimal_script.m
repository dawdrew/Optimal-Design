%% Andrew Rearson MECE 620.01 Intro To Optimal Design
% clc;
clear;
format compact;
n = 1;
%% Function Definition
% given info
interval = [-10, 10];
eps = [.1 , .01, .001];

% functions and optimal value using fminbnd function
mainFunction = @(x) 0.0048 * x.^4 + 0.0329 * x.^3 - 0.1283 * x.^2 - 2.7896 * x.^1 - 9.37301;
mnFn = [0.0048, 0.0329, - 0.1283, - 2.7896, - 9.37301];
sol = fminbnd(mainFunction,interval(1),interval(2));
Fsol = polyval(mnFn,sol);
opt = [sol, Fsol]
% Plots of function and ideal point
% figure
fplot(mainFunction, interval);
hold on
plot(opt(1),opt(2),'+');

% second function stuff
secondFunct = @(q) .1 * q.^3 + 0.2 * q.^2 - 6.5 * q - 5;
scFN = [.1 ,+ 0.2 , - 6.5 , - 5];
fplot(secondFunct,interval);
sol2 = fminbnd(secondFunct,interval(1),interval(2));
Fsol2 = polyval(scFN,sol2);
opt2 = [sol2, Fsol2]
plot(opt2(1),opt2(2),'o');


% call class and pass the function
pt1 = functionsHW2(eps,mnFn,sol,interval);
pt2 = functionsHW2(eps,scFN,sol2,interval);


% large matrix initialize
biResults = zeros(6,7);
powellResults = zeros(6,7);
cubicResults = zeros(6,7);
gsResults = zeros(6,7);
gsTable = zeros(6*30,6);


% %{
%% Bisection
j = 1;
for value=eps
    pt1.eps = value;
    biResults(j:j+1,:) = pt1.Bisection.biRes;
    j = j+2;
end
biResults

%% Powell's Method

j = 1;

for value=eps
    pt1.eps = value;
    powellResults(j:j+1,:) = pt1.Powell.powRes;
    j = j+2;
end
powellResults

%% Cubic Search

j = 1;

for value=eps
    pt1.eps = value;
    cubicResults(j:j+1,:) = pt1.Cubic.cubRes;
    j = j+2;
end
cubicResults

%% Golden Section
j = 1;
for value=eps
    pt1.eps = value;
    gsResults(j:j+1,:) = pt1.GoldenSec.gsRes;
    j = j+2;
end
gsResults
%}
%% results2
%{
Results2 = zeros(12,7);
% methods = ['Bisection', 'Powell', 'Cubic', 'GoldenSec'];
% outputs = ['biRes', 'powRes', 'cubRes', 'gsRes'];
j=1;
for value=eps
    pt2.eps = value;
    tic
    Results2(j+0,:) = pt2.Bisection.biRes;
    Results2(j+0,end) = toc;
    tic
    Results2(j+3,:) = pt2.Powell.powRes;
    Results2(j+3,end) = toc;
    tic
    Results2(j+6,:) = pt2.Cubic.cubRes;
    Results2(j+6,end) = toc;
    tic
    Results2(j+9,:) = pt2.GoldenSec.gsRes;
    Results2(j+9,end) = toc;
j = j+1;    
end
%}
%% Outputs
% first equation
Results = [biResults;powellResults;cubicResults;gsResults]
% obj.output = [fn, xn, iterations, sensitivity, FS, xS, toc];
plotthings = ['^','v','<','>'];
for j = 0:3
    for i = 1:6
        plot(Results(j*6+i,6), Results(j*6+i,5),plotthings(j+1));
    end
end
format shortG

% second equation
%{
Results2
prtrs2 = [1,2,3,10,11,12];
for L = prtrs2
    if L<=3
        j = plotthings(1);
    else
        j = plotthings(2);
    end
        plot(Results2(L,6), Results2(L,5),j);
end
hold off
%}