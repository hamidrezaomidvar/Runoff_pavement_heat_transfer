function [all_vel,al_all,all_vis]=trans_time_adv(t,htrans,I,alpha,s,m,xtrans,vel_lam_first,vel_turb_first)
al_all=[];
y=htrans;
n=size(htrans,2)-size(htrans(htrans>=I*t),2);
all_vel=zeros(m+1,size(htrans,2));
all_vis=zeros(m+1,size(htrans,2));
for jj=1:size(htrans,2)
    if(jj>n)
        
        vel=all_vel(:,n)';
        vis=all_vis(:,n)';
    else
        h=y(jj);
        V=(I*xtrans(jj))/h;
        [vel,vis2,zv2,z0,us,hh]=calculate_vel_vis_turb(I,h,alpha,s);
        z=0:h/m:h;
        vel_turb=interp1(hh,vel,z,'linear','extrap');
        vis_turb=interp1(zv2,vis2,z,'linear','extrap');
        vel_turb(1)=0;
        
        [vel2,vis_lam,hh2]=calculate_vel_vis_lam(I,h,s,alpha,m);
        vel_lam=vel2;
        vel_lam(1)=0;
        
        %al=(V-mean(vel_turb))./(mean(vel_lam)-mean(vel_turb));
        we=(xtrans(jj)-xtrans(end))/(xtrans(1)-xtrans(end));
        al=V/((we)*mean(vel_lam)+(1-we)*mean(vel_turb));
        %vel=al.*vel_lam+(1-al).*vel_turb;
        vel=al*(we.*vel_lam+(1-we).*vel_turb);
        vis=vis_lam+(1-we)*(vis_turb-vis_lam);
        
        al_all=[al_all al];
    end
    
    all_vel(:,jj)=vel';
    all_vis(:,jj)=vis';
    
end
end