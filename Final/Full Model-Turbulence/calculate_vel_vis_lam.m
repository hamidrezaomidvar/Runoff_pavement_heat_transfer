function [vel,vis,hh]=calculate_vel_vis_lam(I,h,s,alpha,m)
g=9.8;
mu=1e-6;
yt=alpha*h;
z=0:(h)/m:h;
aa=1.2;

vel=(g*s*h*alpha/(mu+aa*mu*(h*I/mu)^0.4))*(z-(z.*z)/(2*alpha*h));

vis=(1./(mu/7.5+(1/1.9)*aa*mu*(((h*(I))/mu))^0.4)+0*z).^(-1);

hh=z;

end