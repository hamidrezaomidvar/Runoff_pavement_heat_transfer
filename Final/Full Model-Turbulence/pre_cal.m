function [htu,hla,htrans,dx_t,alpha,flag_turb,t111,t222,xla,xtu,xlaminar,xturb,xtrans,hlaminar,Vlaminar,hturb,Vturb,grad_turb,vel_turb_first]=pre_cal(l,n,kin_vis,I,s,g,m)
dx_t=l/n;
delt_heat=1;
Rel=500;
Ret=1000;
alpha=2/3;
fun=@(h) -Rel+((g*s*alpha*h/(kin_vis+1.2*kin_vis*((h*I/kin_vis)^.4)))*(0.5*h*h-h*h*h/(6*alpha*h)))/kin_vis;
hla=fsolve(fun,0.0001);


htu=hla;
err=1;
max_iter=1000;
counter=0;
while(err>=0.001)
    [vel1,vis21,zv21,z01,us1,hh1]=calculate_vel_vis_turb(I,htu,alpha,s);
    z=0:htu/m:htu;
    vel1=interp1(hh1,vel1,z,'linear','extrap');
    vel1(1)=0;
    err=abs(mean(vel1)*htu/kin_vis-Ret);
    htu=Ret*kin_vis/mean(vel1);
    counter=counter+1;
    err
    if(counter>max_iter)
        break
    end
    
end

%%
t111=hla/I;
t222=htu/I;
xc=kin_vis*(Ret-Rel)/I;
xla=kin_vis*(Rel)/I;
xtu=kin_vis*(Ret)/I;

x=0:dx_t:l;
xlaminar=x(x<=xla);
xturb=x(x>=xtu);
xtemp=x(x>xla);
xtrans=xtemp(xtemp<xtu);
xtrans=[xlaminar(end) xtrans xturb(1)];
xla=xlaminar(end);
xtu=xturb(1);
%%
zt=0:htu/m:htu;
[vel1,vis21,zv21,z01,us1,hh1]=calculate_vel_vis_turb(I,htu,alpha,s);
vist=interp1(zv21,vis21,zt,'linear','extrap');

zl=0:hla/m:hla;
[vel,vis,hh]=calculate_vel_vis_lam(I,hla,s,alpha,m);
visl=vis;

vis_trans=zeros(m+1,size(xtrans,2));
for kk=1:size(xtrans,2)
    
    vis_trans(:,kk)=(1-((xtrans(kk)-xla)/(xtu-xla)))*visl'+((xtrans(kk)-xla)/(xtu-xla))*vist';
    
end

hlaminar=(0.0001/1000)*ones(1,size(xlaminar,2));
Vlaminar=0*ones(1,size(xlaminar,2));

hturb=htu*ones(1,size(xturb,2));
Vturb=0*ones(1,size(xturb,2));

htrans=hla*ones(1,size(xtrans,2));

for t=0:1:10
    [hturb2,all_vel_turb2,all_vis_turb]=turb_time_adv(hturb,I,alpha,s,delt_heat,dx_t,m);
    t
end
b=gradient(hturb2,dx_t);
grad_turb=b(1);
vel_turb_first=all_vel_turb2(:,1);

%%
flag_turb=0;
end