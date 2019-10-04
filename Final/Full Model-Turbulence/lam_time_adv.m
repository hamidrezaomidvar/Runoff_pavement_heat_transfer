function [hlaminar,all_vel,all_vis]=lam_time_adv(hlaminar,I,alpha,s,dt,dx,m)

y=hlaminar;
n=size(hlaminar,2);
ytemp=y;
for jj=2:n
    h=y(jj);
    [vel,vis,hh]=calculate_vel_vis_lam(I,h,s,alpha,m);
    h1=y(jj-1);
    [vel1,vis1,hh1]=calculate_vel_vis_lam(I,h1,s,alpha,m);
    z=0:h/m:h;
    velocity=vel;
    velocity(1)=0;
    velocity1=vel1;
    velocity1(1)=0;
    viscosity=vis;
    V=mean(velocity);
    V1=mean(velocity1);
    ytemp(jj)=y(jj)+dt*(I-(V*y(jj)-V1*y(jj-1))/dx);
    all_vel(:,jj)=velocity';
    all_vis(:,jj)=vis';
    if(jj==2)
        all_vel(:,jj-1)=velocity1';
        all_vis(:,jj-1)=vis1';
    end
end
y=ytemp;
hlaminar=y;
end