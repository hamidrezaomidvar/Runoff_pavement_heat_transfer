function [vel_lam_first,htrans2,height,veloc,visco,hlaminar,hturb,htrans,grad_lam,flag_turb,all_vel_lam,all_vel_trans,all_vel_turb,all_vis_lam,all_vis_trans,all_vis_turb]=cal_everything_turb(vel_lam_first,htrans2,all_vel_lam,all_vel_trans,all_vel_turb,all_vis_lam,all_vis_trans,all_vis_turb,grad_lam,htu,hla,l,I,htrans,dx_t,m,s,delt_heat,alpha,t,flag_turb,t111,t222,xla,xtu,xlaminar,xturb,xtrans,hlaminar,Vlaminar,hturb,Vturb,grad_turb,vel_turb_first)
hall=[];
all_vel=[];
all_vis=[];
if(t<=t111)
    [hlaminar,all_vel_lam,all_vis_lam]=lam_time_adv(hlaminar,I,alpha,s,delt_heat,dx_t,m);
    
    xtt=xlaminar(end):dx_t:l;
    ytt=hlaminar(end)*ones(1,size(xtt,2));
    vtt=repmat(all_vel_lam(:,end),1,size(xtt,2));
    vistt=repmat(all_vis_lam(:,end),1,size(xtt,2));
    hall=[hlaminar ytt(2:end)];
    all_vel=[all_vel_lam vtt(:,2:end)];
    all_vis=[all_vis_lam vistt(:,2:end)];

    b=gradient(hlaminar,dx_t);
    grad_lam=b(end);

elseif(((t>t111)&&(t<t222)))
    if(flag_turb==0)
        eq1=[(0)^3 (0)^2 (0) 1];
        eq2=[(xtu-xla)^3 (xtu-xla)^2 (xtu-xla) 1];
        eq3=[0 0 1 0];
        eq4=[3*(xtu-xla)^2 2*(xtu-xla) 1 0];
        A=[eq1;eq2;eq3;eq4];
        B=[hlaminar(end);htu;grad_lam;grad_turb];
        res_co=linsolve(A,B);
        htrans2=(res_co(1))*((xtrans-xla).^3)+(res_co(2))*((xtrans-xla).^2)+(res_co(3))*((xtrans-xla).^1)+(res_co(4))*((xtrans-xla).^0);
        vel_lam_first=all_vel_lam(:,end);
        flag_turb=1;
    end
    
    htrans=htrans2;
    htrans(htrans>=I*t)=I*t;
    [all_vel_trans,al_all,all_vis_trans]=trans_time_adv(t,htrans,I,alpha,s,m,xtrans,vel_lam_first,vel_turb_first);
    xtt=xtrans(end):dx_t:l;
    ytt=htrans(end)*ones(1,size(xtt,2));
    hall=[hlaminar htrans(2:end) ytt(2:end)];
    vtt=repmat(all_vel_trans(:,end),1,size(xtt,2));
    vistt=repmat(all_vis_trans(:,end),1,size(xtt,2));
    all_vel=[all_vel_lam all_vel_trans(:,2:end) vtt(:,2:end)];
    all_vis=[all_vis_lam all_vis_trans(:,2:end) vistt(:,2:end)];

    
elseif(t>=t222)
    if(flag_turb==1)
        hturb=htrans(end)*ones(1,size(xturb,2));
        flag_turb=2;
    end
    [hturb,all_vel_turb,all_vis_turb]=turb_time_adv(hturb,I,alpha,s,delt_heat,dx_t,m);
    hall=[hlaminar htrans(2:end-1) hturb];
    all_vel=[all_vel_lam all_vel_trans(:,2:end-1) all_vel_turb];
    all_vis=[all_vis_lam all_vis_trans(:,2:end-1) all_vis_turb];
end


height=hall;
veloc=all_vel;
visco=all_vis;




end