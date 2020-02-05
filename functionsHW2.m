%% this is a function file for each of the methods
classdef functionsHW2
    properties
        func
        range
        optimalVal
        biRes
        eps
    end
    methods
        function obj = Bisection(obj,j)
            f = [obj.func];
            sensitivity = 0;
            iterations  = 0;
            done = 0;
            mid = ([obj.range(1)]+ [obj.range(2)]) / 2;
            opt = [obj.optimalVal];
            highVal = [obj.range(1)];
            lowVal  = [obj.range(2)];
            eps = [obj.eps(j)];
% step 1 is make sure bounds work
            while done == 0
                iterations = iterations + 1;
                up  = polyval(polyder(f),highVal);
                low = polyval(polyder(f),lowVal);
                if up<0 && low>0
                    done = 1;
                elseif up>=0
                    highVal = highVal-.01;
                elseif low<=0
                    lowVal = lowVal+.01;   
                end
            end
% step 2 is to solve
            while abs((polyval(f,mid)-polyval(f,opt))/polyval(f,opt)) <= eps && abs((mid-opt)/opt) <= eps
                mid = (lowVal+highVal)/2;
                if polyval(polyder(f),mid)>0
                    lowVal = mid;
                else
                    highVal = mid;
                end
                iterations = iterations + 1;
            end
            epsilon = [(abs(polyval(f,mid)-polyval(f,opt)/polyval(f,opt))), (abs((mid-opt)/opt))];
            [obj.biRes] = [epsilon(1), epsilon(2), iterations, sensitivity];
        end


%         function [epsilon, iterations, sensitivity] = Powell(x,eps, funct)
% 
% 
% 
% 
% 
%         end
% 
%         function [epsilon, iterations, sensitivity] = Cubic(x,eps, funct)
% 
% 
% 
% 
% 
%         end
% 
%         function [epsilon, iterations, sensitivity] = GoldenSec(x,eps, funct)
% 
% 
% 
% 
% 
%         end

    end
end