%% this is a function file for each of the methods
classdef functionsHW2
    properties
        func
        range
        optimalVal
        biRes
        powRes
        cubRes
        eps
    end
    methods
%% Bisection
        function obj = Bisection(obj,j)
            f = [obj.func];
            sensitivity = 0;
            iterations  = 0;
            done = 0;
            mid = ([obj.range(1)]+ [obj.range(2)]) / 2;
            opt = [obj.optimalVal];
            highVal = [obj.range(2)];
            lowVal  = [obj.range(1)];
            epsL = [obj.eps(j)];

            
% step 1 is make sure bounds work
            while done == 0
                iterations = iterations + 1;
                up  = polyval(polyder(f),highVal);
                dow = polyval(polyder(f),lowVal);
                if up>0 && dow<0
                    done = 1;
                elseif up<=0
                    highVal = highVal-.01;
                elseif dow>=0
                    lowVal = lowVal+.01;   
                end
            end
            
            mid = (lowVal+highVal)/2;
            fn = abs((polyval(f,mid)-polyval(f,opt))/polyval(f,opt));
            xn = abs((mid-opt)/opt);

            
% step 2 is to solve
            while (fn > epsL) || (xn > epsL)
                mid = (lowVal+highVal)/2;
                if polyval(polyder(f),mid)<0
                    lowVal = mid;
                    mid = (lowVal+highVal)/2;
                    fn = abs((polyval(f,mid) - polyval(f,opt)) / polyval(f,opt));
                    xn = abs((mid - opt) / opt);
                else
                    highVal = mid;
                    mid = (lowVal+highVal)/2;
                    fn = abs((polyval(f,mid) - polyval(f,opt)) / polyval(f,opt));
                    xn = abs((mid - opt) / opt);
                end
                iterations = iterations + 1;
            end
% -----------------------------Reassign here---------------------------%
            [obj.biRes] = [fn, xn, iterations, sensitivity, polyval(f,mid), mid, 0];
        end

%% Powels 
        function obj = Powell(obj, j)
            f = [obj.func];
            sensitivity = 0;
            iterations  = 1;
            done = 0;
            opt = [obj.optimalVal];
            highVal = [obj.range(1)];
            lowVal  = [obj.range(2)];
            epsL = [obj.eps(j)];
            x1 = highVal;
            x2 = lowVal;
            x3 = lowVal;
            f1 = polyval(f,x1);
            f2 = polyval(f,x2);
            f3 = polyval(f,x3);
            a0 = f1;
            a1 = (f2-f1)/(x2-x1);
            a2 = ((f3-f1)/(x3-x1) - (f2-f1)/(x2-x1)) / (x3-x2);
            xS = (x1+x2) / 2 - a1/(2*a2);
            FS = polyval(f,xS);
            fn = abs((polyval(f,xS) - polyval(f,opt)) / polyval(f,opt));
            xn = abs((xS - opt) / opt);            
            
% -----------------------------Reassign here---------------------------%           
            while (FS > epsL) || (xn > epsL)
               if xS>x2
                   x1 = x2;
                   x2 = xS;
               else 
                   x3 = x2;
                   x2 = xS;
               end
               
                f1 = polyval(f,x1);
                f2 = polyval(f,x2);
                f3 = polyval(f,x3);
                a0 = f1;
                a1 = (f2-f1)/(x2-x1);
                a2 = ((f3-f1)/(x3-x1) - (f2-f1)/(x2-x1)) / (x3-x2);
                xS = (x1+x2) / 2 - a1/(2*a2);
                FS = polyval(f,xS);
                fn = abs((polyval(f,xS) - polyval(f,opt)) / polyval(f,opt));
                xn = abs((xS - opt) / opt);

                iterations = iterations + 1;
            end
            
            
            [obj.powRes] = [fn, xn, iterations, sensitivity, FS, xS, 0];
        end
%% Cubic  
        function obj = Cubic(obj, j)
            f = [obj.func];
            sensitivity = 0;
            iterations  = 1;
            done = 0;
            mid = ([obj.range(1)]+ [obj.range(2)]) / 2;
            opt = [obj.optimalVal];
            highVal = [obj.range(1)];
            lowVal  = [obj.range(2)];
            epsL = [obj.eps(j)];
            x1 = highVal;
            x2 = lowVal;
            f1 = polyval(f,x1);
            
            f2 = polyval(f,x2);
            a0 = f1;
            a1 = (f2-f1)/(x2-x1);
            a2 = ((f3-f1)/(x3-x1) - (f2-f1)/(x2-x1)) / (x3-x2);
            xS = (x1+x2) / 2 - a1/(2*a2);
            FS = polyval(f,xS);
            fn = abs((polyval(f,xS) - polyval(f,opt)) / polyval(f,opt));
            xn = abs((xS - opt) / opt);




        end
%% Golden Sec
%         function [epsilon, iterations, sensitivity] = GoldenSec(x,eps, funct)
% 
% 
% 
% 
% 
%         end

    end
end