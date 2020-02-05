%% Andrew Rearson MECE 620.01 Intro To Optimal Design
clc;
clear;
n = 1;
%% Function Definition
% given info
interval = [-10,10];
eps = [.1 , .01, .001];

% functions
mainFunction = @(x) 0.0048 * x.^4 + 0.0329 * x.^3 - 0.1283 * x.^2 - 2.7896 * x.^1 - 9.37301;
mnFn = [0.0048, 0.0329, - 0.1283, - 2.7896, - 9.37301];
sol = fminbnd(mainFunction,interval(1),interval(2));
fplot(mainFunction,interval);

% % secondFunct = @(q) .1 * q.^3 + 0.2 * q.^2 - 6.5 * q - 5;
% % scFN = [.1 ,+ 0.2 , - 6.5 , - 5];
% % fplot(secondFunct,interval);

% call class and pass the function
pt1 = functionsHW2;
% pt2 = functionsHW2(scFn);
pt1.func = mnFn;
pt1.optimalVal = sol;
% pt2.func = scFn;

%large matrix initialize
biResults = zeros(3,4);
TimeMatrix = zeros(4,3);
powellResults = zeros(3);
cubicResults = zeros(3);
gsResults = zeros(3);
% Results = zeros(3,3,3);
%% Bisection
j=1;
% for value=eps
    tic
    biResults = pt1.Bisection(interval(1), interval(2), eps(j));
    TimeMatrix(n,j) = toc;
    j = j+1;
% end
biResults


n=n + 1;
%% Powell's Method
j = 1;




n=n + 1;
%% Cubic Search
j = 1;




n=n + 1;
%% Golden Section
j = 1;



%% Outputs
% Results = [biResults(:,1:3);powellResults;cubicResults;gsResults];

