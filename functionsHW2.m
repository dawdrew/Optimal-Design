%% this is a function file for each of the methods
classdef functionsHW2
    properties
        func
        range
        optimalVal
        biRes
        powRes
        cubRes
        gsRes
        eps
        gsTABLE
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
            highVal = [obj.range(2)];
            mid = ([obj.range(1)]+ [obj.range(2)]) / 2;
            lowVal  = [obj.range(1)];
            epsL = [obj.eps(j)];
            x1 = highVal;
            x2 = mid;
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
          
            while (fn > epsL) || (xn > epsL)
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
            
% -----------------------------Reassign here---------------------------%             
            [obj.powRes] = [fn, xn, iterations, sensitivity, FS, xS, 0];
        end
%% Cubic  
        function obj = Cubic(obj, j)
            f = [obj.func];
            sensitivity = 0;
            iterations  = 0;
            opt = [obj.optimalVal];
            highVal = [obj.range(2)];
            lowVal  = [obj.range(1)];
            epsL = [obj.eps(j)];
            x1 = lowVal;
            x2 = highVal;
            xn = 100;
            fn = 100;
            
            while (fn > epsL) || (xn > epsL)
                f1 = polyval(f,x1);
                fp1 = polyval(polyder(f),x1);
                f2 = polyval(f,x2);
                fp2 = polyval(polyder(f),x2);
                a0 = f1;
                a1 = (f2-f1)/(x2-x1);
                a2 = (fp1-a1)/(x1-x2);
                a3 = (fp2-a1-a2*(x2-x1))/(x2-x1)^2;

    %             FS = @(x) a0+a1*(x-x1)+a2*(x-x1)*(x-x2)+a3*(x-x1).^2*(x-x2);
                FpS = @(m) a1+a2.*(m-x1)+a2.*(m-x2)+a3.*(m-x1).^2+2.*a3.*(m-x2).*(m-x1).^2;
%                 fplot(FpS,limits)
                xS = fzero(FpS,x1);
                fpxS = polyval(polyder(f),xS);
                FS = polyval(f,xS);
                
                if fpxS >= 0
                    x2 = xS;
                else
                    x1 = xS;
                end

                fn = abs((polyval(f,xS) - polyval(f,opt)) / polyval(f,opt));
                xn = abs((xS - opt) / opt);
                iterations = iterations +1;
            end
            
% -----------------------------Reassign here---------------------------% 
[obj.cubRes] = [fn, xn, iterations, sensitivity, FS, xS, 0];

        end
%% Golden Sec
        function obj = GoldenSec(obj, j)
            f = [obj.func];
            sensitivity = 0;
            iterations  = 1; 
            opt = [obj.optimalVal];
            highVal = [obj.range(2)];
            lowVal  = [obj.range(1)];
            epsL = [obj.eps(j)];
            limits = [obj.range];
                
            xL = lowVal;
            xR = highVal;
            t  = .38197;
            x1 = (1-t)*xL+t*xR;
            x2 = t*xL+(1-t)*xR;

            n = 30;
            table = zeros(n,7);
            for i = 1:n
                fx1 = polyval(f,x1);
                fx2 = polyval(f,x2);

                if fx1<fx2
                    table(i,:) = [iterations, x1, fx1, xL, x1, x2, xR];
                    xR = x1;
                    x1 = (1-t)*xL+t*xR;
                else
                    table(i,:) = [iterations, x2, fx2, xL, x1, x2, xR];
                    xL = x2;
                    x2 = t*xL+(1-t)*xR;
                end

                iterations = iterations + 1;
            end
            [obj.gsTABLE] = table;
            table
            mini = max(min(table(:,3)));
            [x,y] = find(table == mini)
            xS = table(x-1,y)
            FS = polyval(f,xS);
            fn = abs((FS - polyval(f,opt)) / polyval(f,opt));
            xn = abs((xS - opt) / opt);
           
            
% -----------------------------Reassign here---------------------------% 
    [obj.gsRes] = [fn, xn, iterations, sensitivity, FS, xS, 0];

        end

    end
end