%% Andrew Rearson MECE 620.01 Intro To Optimal Design
clc;
clear;
n = 1; %
C = functionsHW2;
%% Function Definition
% given info
interval = [-10,10];
eps = [.1,.01,.001];

mainFunction = @(x) 0.0048 * x.^4 + 0.0329 * x.^3 - 0.1283 * x.^2 - 2.7896 * x.^1 - 9.37301;

fplot(mainFunction,interval);
% secondFunct = @(q) .1 * q.^3 + 0.2 * q.^2 - 6.5 * q - 5;
% plot(secondFunct);
%% Bisection
j=1;
for eps
    tic
    biResults(j) = C.Bisection(interval(1), interval(2), eps(j), mainFunction);
    TimeMatric(n,j)=toc;
end



n=n + 1;
%% Powell's Method





n=n + 1;
%% Cubic Search





n=n + 1;
%% Golden Section





