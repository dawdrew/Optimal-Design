%% Homework4
% andrew Rearson

clc;
clear all; %#ok<CLALL>
close all;
format compact


mF = @(x1,x2) 5 .* (x1).^2 + 7 .* (x2).^2 - 3 .* x1...
    - 4 .* x2 .* x1 + 2 .* x2;
syms x1 x2 x01 x02 a s1 s2
mFsyms =      5 .* (x1).^2 + 7 .* (x2).^2 - 3 .* x1...
    - 4 .* x2 .* x1 + 2 .* x2;

x1INT = [-2,2];
x2INT = [-2,2];
INT = [x1INT , x2INT];
fig_given = figure('Name',"GivenInfo_4.1",'NumberTitle','off');
fig_temp = figure('Name',"Temp",'NumberTitle','off');
figure(fig_temp)
fc = fcontour(mF, INT);
Pt0 = [5 2];
x1V(1,1) = Pt0(1,1);
x2V(1,1) = Pt0(1,2);
LabeLine = [0 0 2 2 4 4 6 6 10 10 15 15 20 20 25 25 50 50];
% linelable = [0,2,4,6,10,20,25,50];

%% %%%%%%%%%%%%%%%%%%%%%%%%% 4.1 Graphs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_given);
hold on
title(func2str(mF))
xlabel x1
ylabel x2
[M, c] = contour(fc.XData,fc.YData, fc.ZData, LabeLine, 'ShowText','on');
c.LineColor = 'black';
c.DisplayName = func2str(mF);
grid on
axis equal
legend
hold off

%%%%%%%%%%%%%%%%

g1 = @(x1, x2) 4 .* x1 + 2 .* x2-1;
g1syms = 4 * x1 + 2 * x2-1;
g2 = @(x1, x2) -x2+0.5;
g2syms = -x2+0.5;
figure(fig_temp) %%%%%%%%%

hold on
fc_g1 = fcontour(g1, INT);
g1_lim = [0 0  ... 100 100
    ];
fc_g2 = fcontour(g2, INT);
g2_lim = [0 0 ... 
    ];
hold off

%%%%%%%%%%%%%%%%%

figure(fig_given)
hold on
[M1, c1] = contour(fc_g1.XData,fc_g1.YData, fc_g1.ZData ...
    , g1_lim, 'ShowText','on');
[M2, c2] = contour(fc_g2.XData,fc_g2.YData, fc_g2.ZData ...
    , g2_lim,'ShowText','on');
%%%%%%%%%%%%%%%%%%%%%
figure(fig_given);
c1.DisplayName = "g1 = 0";
c2.DisplayName = "g2 = 0";
c1.LineColor = "#77AC30";
c2.LineColor = "#77AC30";
c1.LineWidth = 2;
c2.LineWidth = 2;
saveas(fig_given, 'HW4_contour_noFILL.png');
c1.Fill = 'on';
c2.Fill = "on";
saveas(fig_given, 'HW4_contour_FILLon.png');
% close(1)

%% %%%%%%%%%%%%%%% 4.2 Exterior Penalty and StationartyPts %%%%%%%%%%

fig_42 = figure('Name',"Prob_4.2",'NumberTitle','off');

x1_max = 1;
x1_min = -2;
x2_max = 2;
x2_min = -1;

limits = [x1_min x1_max x2_min x2_max];

figure(fig_42)

%%%%%%%% sub 1: r=1 %%%%%%%%%%%
RP1 = subplot(1,2,1);
rp = 1;
objFUN1 = @(x1, x2) mF(x1, x2) + rp .*...
    (max(0,g1(x1,x2)).^2+ max(0,g2(x1,x2)).^2);
fr1 = fcontour(objFUN1, limits, 'Visible','off'); ...'LineColor','r','DisplayName','ObjFn');
fpr1 = contour(fr1.XData,fr1.YData,fr1.ZData,LabeLine,'red','ShowText','on');
hold on
title('rp = 1')
 %%old graph stuff here%%
xlabel x1
ylabel x2
grid on
axis equal
lgd = legend('rp = 1');
lgd.Location = "southoutside";
axis(limits); 
%%%%%%%%%%%%%%%%%old pts%%%%%%%%%%%%%%%%%%%%%%%%%%
[M1, c1] = contour(fc_g1.XData,fc_g1.YData, fc_g1.ZData ...
    , g1_lim, 'ShowText','on');
[M2, c2] = contour(fc_g2.XData,fc_g2.YData, fc_g2.ZData ...
    , g2_lim,'ShowText','on');
c1.DisplayName = "g1 = 0";
c1r1 = c1;
c2.DisplayName = "g2 = 0";
c2r1 = c2;
c1.LineColor = "#77AC30";
c2.LineColor = "#77AC30";
c1.LineWidth = 2;
c2.LineWidth = 2;
hold off

%%%%%%%%%%%%% sub 2: r = 2 %%%%%%%%%%%%%
RP10 = subplot(1,2,2);
rp = 10;
objFUN1 = @(x1, x2) mF(x1, x2) + rp .*...
    (max(0,g1(x1,x2)).^2+ max(0,g2(x1,x2)).^2);
fr10 = fcontour(objFUN1, limits, 'Visible','off');
fpr10 = contour(fr10.XData,fr10.YData,fr10.ZData,LabeLine,'red','ShowText','on');
hold on
title('rp = 10')
 %%old graph stuff here%%
xlabel x1
ylabel x2
grid on
axis equal
lgd = legend('Rp = 10');
lgd.Location = "southoutside";
axis(limits); 
%%%%%%%%%%%%%old pts%%%%%%%%%%%%%%%%%%%%%%
[M1, c1] = contour(fc_g1.XData,fc_g1.YData, fc_g1.ZData ...
    , g1_lim, 'ShowText','on');
[M2, c2] = contour(fc_g2.XData,fc_g2.YData, fc_g2.ZData ...
    , g2_lim,'ShowText','on');
c1.DisplayName = "g1 = 0";
c2.DisplayName = "g2 = 0";
c1.LineColor = "#77AC30";
c2.LineColor = "#77AC30";
c1.LineWidth = 2;
c2.LineWidth = 2;
%%%
% [M, c] = contour(fc.XData,fc.YData, fc.ZData, LabeLine,'--');
% c.LineColor = 'black';
% c.DisplayName = 'GivenFunction';

hold off

%%%%%%%%%%%%%%%%%%%%  stationaryPTS  %%%%%%%%%%%%%%%%%%%%%%
syms x1 x2 rp_

objFUN1_syms =  mFsyms + rp_ *...
    (g1syms^2+ g2syms^2)
dx1 = solve(diff(objFUN1_syms,x1)==0,x1)
dx2 = solve(diff(objFUN1_syms,x2)==0,x2)


ONLYx1 = subs(dx1,x2,dx2)
x1_in_rp = solve(x1==ONLYx1,x1)
% ONLYx2 = subs(dx2,x1,dx1)
% x2_in_rp = solve(ONLYx2,x2)

x1_stat_1 = double(subs(x1_in_rp,rp_,1))
x1_stat_10 = double(subs(x1_in_rp,rp_,10))
x1_stat_inf = double(subs(x1_in_rp,rp_,999999999999999999999))
x2_from_1 = subs(dx2, [x1,rp_],[x1_stat_1,1])
x2_from_10 = subs(dx2, [x1,rp_],[x1_stat_10,10])
x2_from_i = double(subs(dx2, [x1,rp_],[x1_stat_inf,9999999999999999]))
% x2_stat_1 = double(subs(x2_in_rp,rp_,1))
% x2_stat_10 = double(subs(x2_in_rp,rp_,10))
% x2_stat_inf = double(subs(x2_in_rp,rp_,999999999999999999999))

subplot(RP1)
hold on
plot(x1_stat_1,x2_from_1,'Marker','*',...
    'DisplayName',sprintf('rp = 1 @ %.3g, %.3g',x1_stat_1,x2_from_1),...
    'MarkerSize',20,'Color','#D95319')
plot(x1_stat_inf,x2_from_i,'Marker','*',...
    'DisplayName',sprintf('rp = inf @ %.3g, %.3g',x1_stat_inf,x2_from_i),...
    'MarkerSize',20,'Color','w')
hold off
subplot(RP10)
hold on
plot(x1_stat_10,x2_from_10,'Marker','*',...
    'DisplayName',sprintf('rp = 10 @ %.3g, %.3g',x1_stat_10,x2_from_10),...
    'MarkerSize',20,'Color','#D95319')
plot(x1_stat_inf,x2_from_i,'Marker','*',...
    'DisplayName',sprintf('rp = inf @ %.3g, %.3g',x1_stat_inf,x2_from_i),...
    'MarkerSize',20,'Color','w')
hold off

%%%%%%%%%%%%%%% save %%%%%%%%%%%%%%%

saveas(fig_42, 'HW4_4-2_FILLoff.png');
subplot(RP1)
hold on
c1r1.Fill = 'on';
c2r1.Fill = 'on';
subplot(RP10)
c1.Fill = 'on';
c2.Fill = 'on';
hold off
saveas(fig_42, 'HW4_4-2_FILLon.png');
%% %%%%%%%%%%%%%%%%% 4.3 Interior Penalty %%%%%%%%%%%%%%%%%%%%%%%%

fig_43 = figure('Name',"Prob_4.3",'NumberTitle','off');

x1_max = .5;
x1_min = -2;
x2_max = 2;
x2_min = -1;
eps = -.05;

limits = [x1_min x1_max x2_min x2_max];

figure(fig_43)

%%%%%%%% sub 1: r=1 %%%%%%%%%%%
RpP1 = subplot(1,2,1);
rpm = 1;
f=@EXinPENfn;
objFUN2 = @(x1, x2) mF(x1, x2) + rpm .* (f(x1,x2,eps));
% fminunc(objFUN2,[0 0])
fr1 = fcontour(objFUN2, limits, 'Visible','off');
fpr1 = contour(fr1.XData,fr1.YData,fr1.ZData,LabeLine,'red','ShowText','on');
hold on
title('rp'' = 1')
 %%old graph stuff here%%
xlabel x1
ylabel x2
grid on
axis equal
lgd = legend('rp'' = 1');
lgd.Location = "southoutside";
axis(limits); 
%%%%%%%%%%%%%%%%%old pts%%%%%%%%%%%%%%%%%%%%%%%%%%
[M1, c1] = contour(fc_g1.XData,fc_g1.YData, fc_g1.ZData ...
    , g1_lim, 'ShowText','on'); %#ok<*ASGLU>
[M2, c2] = contour(fc_g2.XData,fc_g2.YData, fc_g2.ZData ...
    , g2_lim,'ShowText','on');
c1.DisplayName = "g1 = 0";
c1r1 = c1;
c2.DisplayName = "g2 = 0";
c2r1 = c2;
c1.LineColor = "#77AC30";
c2.LineColor = "#77AC30";
c1.LineWidth = 2;
c2.LineWidth = 2;

hold off

%%%%%%%%%%%%% sub 2: r = 0.1 %%%%%%%%%%%%%
RpP01 = subplot(1,2,2);

rpm = 0.1;
f=@EXinPENfn;
objFUN2 = @(x1, x2) mF(x1, x2) + rpm .* ...
    f(x1,x2,eps);
fr1 = fcontour(objFUN2, limits); ..., 'Visible','off'); ...'LineColor','r','DisplayName','ObjFn');
fpr1 = contour(fr1.XData,fr1.YData,fr1.ZData,LabeLine,'red','ShowText','on');
hold on
title('rp'' = 0.1')
 %%old graph stuff here%%
xlabel x1
ylabel x2
grid on
axis equal
lgd = legend('rp'' = 0.1');
lgd.Location = "southoutside";
axis(limits); 
%%%%%%%%%%%%%%%%%old pts%%%%%%%%%%%%%%%%%%%%%%%%%%
[M1, c1] = contour(fc_g1.XData,fc_g1.YData, fc_g1.ZData ...
    , g1_lim, 'ShowText','on');
[M2, c2] = contour(fc_g2.XData,fc_g2.YData, fc_g2.ZData ...
    , g2_lim,'ShowText','on');
c1.DisplayName = "g1 = 0";
c2.DisplayName = "g2 = 0";
c1.LineColor = "#77AC30";
c2.LineColor = "#77AC30";
c1.LineWidth = 2;
c2.LineWidth = 2;

hold off


%%%%%%%%%%%%%%%%%%%% Solve for pts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pl = [RpP1,RpP01];
x = 1;
for rpp = [1,0.1,.0000001]
    small = [-10,10];
    objFUN2 = @(x1, x2) mF(x1, x2) + rpp .* ...
        f(x1,x2,eps);    
    for i1 = limits(1):.01:limits(2)
        for i2 = limits(3):.01:limits(4)
            if objFUN2(small(1),small(2)) > objFUN2(i1,i2)
                small = [i1 i2];

            end
        end
    end
    if x<2
    subplot(pl(x))
    end
    hold on
    plot(small(1),small(2),'Marker','*','DisplayName',...
        sprintf('rp''_m_i_n %.3g @ %.3g,%.3g',rpp,small),...
        'MarkerSize',20,'Color','b'); 
    fprintf('rp found at: x1 %.3g ,  x2 %.3g \n',small(1),small(2))
    x=x+1;
    hold off
end
% for x = [1,2]
%    subplot(pl(x))
%    hold on
%    plot(small(1),small(2),'Marker','*','DisplayName',...
%         sprintf('rp''_i_n_f @ %.3g,%.3g',small),...
%         'MarkerSize',20,'Color','w'); 
%    hold off
% end
saveas(fig_43, 'HW4_4-3_FILLoff.png');
subplot(pl(1))
hold on
c1r1.Fill = 'on';
c2r1.Fill = 'on';
subplot(pl(2))
c1.Fill = 'on';
c2.Fill = 'on';
hold off
saveas(fig_43, 'HW4_4-3_FILLon.png');


%% %%%%%%%%%%%%%%%%%%%%%%%%% 4.4 ALM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig_44 = figure('Name',"Prob_4.4",'NumberTitle','off');
figure(fig_44)
lamPLT1 = subplot(1,2,1);
subplot(lamPLT1)
limits = [-1 1 -1 1.5];
hold on
title('Given Lamda {3,24}')
xlabel x1
ylabel x2
grid on
axis equal
lgd = legend;
lgd.Location = "southoutside";
axis(limits); 
%%%%%%%%%%%%%%%%%old pts%%%%%%%%%%%%%%%%%%%%%%%%%%
[M1, c1] = contour(fc_g1.XData,fc_g1.YData, fc_g1.ZData ...
    , g1_lim, 'ShowText','on'); %#ok<*ASGLU>
[M2, c2] = contour(fc_g2.XData,fc_g2.YData, fc_g2.ZData ...
    , g2_lim,'ShowText','on');
c1.DisplayName = "g1 = 0";
c1r1 = c1;
c2.DisplayName = "g2 = 0";
c2r1 = c2;
c1.LineColor = "#77AC30";
c2.LineColor = "#77AC30";
c1.LineWidth = 2;
c2.LineWidth = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RP = 1;
lam1 = [3;24];
lam2 = [-5;-5];
% trid1 = @(x1,x2,l1) max(g1(x1,x2),-l1/(2* rp));
tr1sym = g1syms;
tr2sym = g2syms;
% trid2 = @(x1,x2,l2) max(g2(x1,x2),-l2/(2* rp));
% lam11 = lam1(1);
% lam12 = lam1(2);
syms x1 x2 L T
for x_squiggle = 1:6
A = mFsyms+(L * tr1sym + rp_ * tr1sym^2)+ (T * tr2sym + rp_ * tr2sym^2);

dx1_A = solve(diff(A,x1) == 0,x1);
dx2_A = solve(diff(A,x2) == 0,x2);


x1_interum = vpa(solve(subs(dx1_A, x2,...
                            dx2_A)==x1,x1))
x1_new = vpa(subs(x1_interum,[L,T,rp_],...
                             [lam1(1,1),lam1(2,1),RP]))
x2_new = vpa(solve(subs(dx2_A,[x1,L,T,rp_],...
                            [x1_new,lam1(1,1),lam1(2,1),RP])...
                            ==x2,x2))
lam1 = [lam1(1,1)+2*RP*g1(x1_new,x2_new);lam1(2,1)+2*RP*g2(x1_new,x2_new)]
xes(:,x_squiggle) = [x1_new;x2_new];
plot(x1_new,x2_new,'Marker','*','DisplayName',...
        sprintf('x_n_e_w #%i @ %.3g,%.3g',x_squiggle,x1_new,x2_new),...
        'MarkerSize',20,'Color','b'); 
end
plot(xes(1,:).',xes(2,:).','DisplayName','Path')



hold off



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lamPLT2 = subplot(1,2,2);
subplot(lamPLT2)
hold on
title('Given Lamda {-5-5}')
xlabel x1
ylabel x2
grid on
axis equal
lgd = legend;
lgd.Location = "southoutside";
axis(limits); 
%%%%%%%%%%%%%%%%%old pts%%%%%%%%%%%%%%%%%%%%%%%%%%
[M1, c1] = contour(fc_g1.XData,fc_g1.YData, fc_g1.ZData ...
    , g1_lim, 'ShowText','on'); %#ok<*ASGLU>
[M2, c2] = contour(fc_g2.XData,fc_g2.YData, fc_g2.ZData ...
    , g2_lim,'ShowText','on');
c1.DisplayName = "g1 = 0";
c2.DisplayName = "g2 = 0";
c1.LineColor = "#77AC30";
c2.LineColor = "#77AC30";
c1.LineWidth = 2;
c2.LineWidth = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


RP = 1;
% trid1 = @(x1,x2,l1) max(g1(x1,x2),-l1/(2* rp));
tr1sym = g1syms;
tr2sym = g2syms;
% trid2 = @(x1,x2,l2) max(g2(x1,x2),-l2/(2* rp));
syms x1 x2 L T
for x_squiggle = 1:6
A = mFsyms+(L * tr1sym + rp_ * tr1sym^2)+ (T * tr2sym + rp_ * tr2sym^2);

dx1_A = solve(diff(A,x1) == 0,x1);
dx2_A = solve(diff(A,x2) == 0,x2);


x1_interum = vpa(solve(subs(dx1_A, x2,...
                            dx2_A)==x1,x1));
x1_new = vpa(subs(x1_interum,[L,T,rp_],...
                             [lam2(1,1),lam2(2,1),RP]));
x2_new = vpa(solve(subs(dx2_A,[x1,L,T,rp_],...
                            [x1_new,lam2(1,1),lam2(2,1),RP])...
                            ==x2,x2));

lam2 = [lam2(1,1)+2*RP*g1(x1_new,x2_new);lam2(2,1)+2*RP*g2(x1_new,x2_new)];
xes(:,x_squiggle) = [x1_new;x2_new];
plot(x1_new,x2_new,'Marker','*','DisplayName',...
        sprintf('x_n_e_w #%i @ %.3g,%.3g',x_squiggle,x1_new,x2_new),...
        'MarkerSize',20,'Color','b'); 
end
plot(xes(1,:).',xes(2,:).','DisplayName','Path')



hold off

pl = [lamPLT1,lamPLT2];
saveas(fig_44, 'HW4_4-4_FILLoff.png');
subplot(pl(1))
hold on
c1r1.Fill = 'on';
c2r1.Fill = 'on';
subplot(pl(2))
c1.Fill = 'on';
c2.Fill = 'on';
hold off
saveas(fig_44, 'HW4_4-4_FILLon.png');





%% function(s)
function gS = EXinPENfn(i,j,eps)
g1 = @(x1, x2) 4 .* x1 + 2 .* x2-1;
g2 = @(x1, x2) -x2+0.5;

        if g1(i,j)<= eps %#ok<*IJCL>
            g1_new=@(i,j) -1./g1(i,j);
        else
            g1_new=@(i,j) -((2.*eps-g1(i,j))./eps^2);
        end
        if g2(i,j)<= eps
            g2_new=@(i,j) -1./g2(i,j);
        else
            g2_new=@(i,j) -((2.*eps-g2(i,j))./eps^2);
        end
        gS = g1_new(i,j)+g2_new(i,j);
end


