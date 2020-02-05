%% this is a function file for each of the methods
classdef functionsHW2
    properties
        func
    end
    methods
        function [epsilon, iterations, sensitivity, done] = Bisection(obj, highVal, lowVal, eps)
            f = [obj.func];
            epsilon = eps;
            sensitivity = 0;
            iterations  = 0;
            done = 0;
            mid = highVal;
            optimum = fzero(;
%step 1 is make sure bounds work
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
            while abs((polyval(mid)-polyval(optimim))/polyval(optimum)   
                mid = (lowVal+highVal)/2;
                if polyval(polyder(f),mid)>0
                    lowVal = mid;
                else
                    highVal = mid;
                end
            oldmid = mid;
            end
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