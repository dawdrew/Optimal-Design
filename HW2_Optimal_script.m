%% Andrew Rearson MECE 620.01 Intro To Optimal Design
clc;
clear;
format compact;
n = 1;
%% Function Definition
% given info
interval = [-10, 10];
eps = [.1 , .01, .001];

% functions
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
opt2 = [sol2, Fsol2];
plot(opt2(1),opt2(2),'o');


% call class and pass the function
pt1 = functionsHW2(eps,mnFn,sol,interval);
% pt1.func = mnFn;
% pt1.optimalVal = sol;
% pt1.range = interval;

% pt1.eps = eps;
% pt2.func = scFn;
% pt2 = functionsHW2(scFn);


% large matrix initialize
biResults = zeros(3,7);
% TimeMatrix = zeros(4,3);
powellResults = zeros(3,7);
cubicResults = zeros(3,7);
gsResults = zeros(3,7);
gsTable = zeros(3*30,6);
% Results = zeros(3,3,3);


%% Bisection
j = 1;
for value=eps
    pt1.eps = value;
    tic
    biResults(j,:) = pt1.Bisection.biRes;
    biResults(j,end) = toc;
    j = j+1;
end
biResults

n = n + 1;
%% Powell's Method

j = 1;

for value=eps
    pt1.eps = value;
    tic
    powellResults(j,:) = pt1.Powell.powRes;
    powellResults(j,end) = toc;
    j = j+1;
end
powellResults

n = n + 1;
%% Cubic Search

j = 1;

for value=eps
    tic
    pt1.eps = value;
    cubicResults(j,:) = pt1.Cubic.cubRes;
    cubicResults(j,end) = toc;
    j = j+1;
end
cubicResults

n = n + 1;
%% Golden Section
j = 1;
for value=eps
    pt1.eps = value;
    tic
    gsResults(j,:) = pt1.GoldenSec.gsRes;
    gsResults(j,end) = toc;
    j = j+1;
end
gsResults


%% Outputs
Results = [biResults;powellResults;cubicResults;gsResults]
plotthings = ['^','v','<','>'];
for j = 0:2
    for i = 1:4
        plot(Results(j*4+i,6), Results(j*4+i,5),plotthings(j+1));
%         out = [Results(j*4+i,6), Results(j*4+i,5)]
    end
end
hold off