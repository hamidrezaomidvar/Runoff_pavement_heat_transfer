function [vel,hh]=calculate_vel_vis_trans(h,s,alpha,vistr,m)
g=9.8;

yt=alpha*h;
us=(g*s*yt)^.5;
ztr=0:h/m:h;
a=fit(ztr',vistr,'poly4');
cf = coeffvalues(a);

[hh,vel]=ode45(@(zp,y) ((1/(cf(1)*(zp^4)+(cf(2))*(zp^3)+(cf(3))*(zp^2)+(cf(4))*(zp)+cf(5)))*(us*us*(1-zp/yt))),ztr,0);




end