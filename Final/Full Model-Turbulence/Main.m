%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Runoff-Pavement heat transfer model
Written by Hamidreza Omidvar
Omidvar.hamidreza@gmail.com
Last modified of this version: September 2018
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clear
clc
close all
clear global variable
[data,time,pr]=loadData_during_rain(); % loading the data for the rainfall duration
glob_variable(pr) %specifying the global variables: the column number of the weather properties in "data"
name_file='Result/base_run'; % name of file you wish to save the workspace in
%% Parameters of the problem
[albedo,dely_air,rho_air,cp_air,DWater_Molecular,mg,m,n,s,I,g,kin_vis,L_water,l,delt_heat,t_tot_heat,K_asphalt,K_water,K_air,rho_asphalt,cp_asphalt,rho_rain,cp_water]=param_properties(time,pr);
%% some geometry matrix initilization. it includes parameters needed for dynamic mesh
y=zeros(m+1,n+1);
x=zeros(m+1,n+1);
yq=zeros(m+1,n+1);
xq=zeros(m+1,n+1);
yg=zeros(mg+1,n+1);
xg=zeros(mg+1,n+1);
yqg=zeros(mg+1,n+1);
xqg=zeros(mg+1,n+1);
hq_top=0;
%%
% Note: T: runoff temperature matrix. Tg: Subsurface Temperature
%%
steadyState=0; %Runoff dynamic is not steady state at the begining. Therefore, dynamic mesh is called later
%% this part is the initial part of the rain where there is a stagnent layer growing
hc=.5/1000; % final thickness of stagnent layer
hc0=.1/1000; %inital thicness of the layer
t_start=-((hc-hc0)/I);
Ir=I;
I=I*((hc-hc0)/I)/(-t_start); % modified version of rain intensity based on the thickness of layer and time
% note that this modified version of I is equal to I here but for the
% experimental data, it is not and t_start was defined there.
%% calculating some of subsurface properties
[diff_asphalt,delyg]=Ground_properties(K_asphalt,rho_asphalt,cp_asphalt,t_tot_heat,mg);
%% before rainfall initialization
[Tg_stable,res_tg,res_sw,res_airt,res_lw]=ground_prof(albedo,mg,delyg,K_asphalt,cp_air,dely_air,diff_asphalt);
%% Setting temperature of subsurface and runoff after initilization period
Tg_init=Tg_stable(1,1);
[T]=temp_properties(m,n,Tg_init);
Tg=zeros(mg+1,n+1);
for i=1:mg+1
    Tg(i,:)=Tg_stable(mg+1-(i-1),1);
end
%% calculation of ustar
ustar=ustar_cal(data,time,dely_air);
%%
counter=0;
f=1; % frequency of stroing results in s
num=ceil(f/delt_heat);
%% definig some arrays for storing the results
res1_1=zeros(1,t_tot_heat);
res1_2=zeros(1,t_tot_heat);
res2_1=zeros(1,t_tot_heat);
res3_1=zeros(1,t_tot_heat);
res3_1_4=zeros(1,t_tot_heat);
res4_1_3=zeros(1,t_tot_heat);
Tb=zeros(1,t_tot_heat);
height_time=zeros(1,t_tot_heat);
u_end_avg=zeros(1,t_tot_heat);
EVAP=zeros(1,t_tot_heat);
GR=zeros(1,t_tot_heat);
GS_W=zeros(1,t_tot_heat);
W_WS=zeros(1,t_tot_heat);
HE=zeros(1,t_tot_heat);
Rai=zeros(1,t_tot_heat);
SW=zeros(1,t_tot_heat);
LW=zeros(1,t_tot_heat);
deltay=zeros(1,t_tot_heat);
deltaz=zeros(1,t_tot_heat);
ef=zeros(1,t_tot_heat);
tr=zeros(1,t_tot_heat);
grad_t=zeros(1,t_tot_heat);
grad_2t=zeros(1,t_tot_heat);
grad_2t_b=zeros(1,t_tot_heat);
grad_2t_t=zeros(1,t_tot_heat);
AA1=zeros(1,t_tot_heat);
AA2=zeros(1,t_tot_heat);
AA3=zeros(1,t_tot_heat);
%%
counter_1=0;
count_dyn=-1;
delt_heat_tmp=delt_heat;
multy=25; % dynamic time step at the begining. the inital time step is multy*delt_heat
%%
[htu,hla,htrans,dx_t,alpha,flag_turb,t111,t222,xla,xtu,xlaminar,xturb,xtrans,hlaminar,Vlaminar,hturb,Vturb,grad_turb,vel_turb_first]=pre_cal(l,n,kin_vis,I,s,g,m);
%%
%Main time loop
grad_lam=0;
all_vel_lam=0;all_vel_trans=0;all_vel_turb=0;all_vis_lam=0;all_vis_trans=0;all_vis_turb=0;
htrans2=0;
vel_lam_first=0;
height=0;
visco=0;
veloc=0;
for t=t_start:delt_heat:t_tot_heat+t_start
    if(t<0)
        hc=hc0+I*(t-t_start); % Growth of stagnent layer
    else
        if count_dyn==-1
            counter=0;
        end
        % Dynamic time step stuff
        I=Ir;
        count_dyn=count_dyn+1;
        t=t+count_dyn*(multy-1)*delt_heat_tmp;
        delt_heat=multy*delt_heat_tmp;
        num=ceil(f/delt_heat);
    end
    if t>t_tot_heat+t_start
        break;
    end
    ind=t+cell2mat(pr(1,14))-t_start;
    ff=ceil(ind);
    Train=data{1}(ff,7);% setting rain temp to air temp
    y_old=y;
    
    if(steadyState==0) %dynamic mesh loop. Here we used modified equations to not interpolate (paper 3)
        hqq=hq_top;
        T_p_temp=T;
        if(t>0)
           [vel_lam_first,htrans2,height,veloc,visco,hlaminar,hturb,htrans,grad_lam,flag_turb,all_vel_lam,all_vel_trans,all_vel_turb,all_vis_lam,all_vis_trans,all_vis_turb]=cal_everything_turb(vel_lam_first,htrans2,all_vel_lam,all_vel_trans,all_vel_turb,all_vis_lam,all_vis_trans,all_vis_turb,grad_lam,htu,hla,l,I,htrans,dx_t,m,s,delt_heat,alpha,t,flag_turb,t111,t222,xla,xtu,xlaminar,xturb,xtrans,hlaminar,Vlaminar,hturb,Vturb,grad_turb,vel_turb_first); 
        end
        [x,y,T,n1,h_top,xq,yq,hq_top,steadyState]=inter_mesh(height,hc,g,kin_vis,t,I,s,n,m,x,y,T,l,steadyState);
        Tg(mg+1,:)=T(1,:);
        [ety,xix,etx,det,dxi]=Transfer_mesh(height,t,hc,m,s,I,x,y,n1,h_top,n,l,g,kin_vis);
        [DFlow,DFlow_y]=diffusivity(t,visco,m,n,DWater_Molecular);
        [ vel_prof,vel_prof_y]=Velocity_Profile(veloc,t,hc,x,y,s,g,I,n,m,kin_vis);
        delta_y=h_top-hqq;
        dy_current=h_top/(m);
        if(t>=900)
           steadyState=1; 
        end
    end
    % Saving some results. Note all of them are usefull.
    if(mod(counter,num)==0)
        counter_1=counter_1+1;
        res2_1(1,counter_1)=(y(end,end)-hc)*1000;
        res3_1(1,counter_1)=mean(T(1,:));
        res3_1_4(1,counter_1)=mean(T(1,end-floor(n/4):end));
        res4_1_3(1,counter_1)=mean(T(end,:));
        Tb(1,counter_1)=mean(mean(T(:,:)));
        height_time(1,counter_1)=y(end,end);
        u_end_avg(1,counter_1)=mean(vel_prof(:,end));
    end
    %% Main Heat calculation function
    [A1,A2,A3,LW_all,lwupM,lwupE,T,Tg,top,bottom,eva_heat,rain_heat,heat_w_ws,heat_H]=Heat(x,y_old,albedo,vel_prof_y,dely_air,n1,T,ety,xix,etx,diff_asphalt,delyg,xg,Tg,rho_air,cp_air,y,mg,m,n,dxi,det,DFlow,DFlow_y,L_water,I,vel_prof,delt_heat,K_asphalt,K_water,Train,rho_rain,cp_water,data,t-t_start,ind,t,ustar);
    %% Saving some of the outputs based on the frequency specified. Note all of them are usuefull outputs
    if(mod(counter,num)==0)
        EVAP(1,counter_1)=top(1,2);
        GR(1,counter_1)=bottom(1,3);
        GS_W(1,counter_1)=bottom(1,2);
        W_WS(1,counter_1)=top(1,4);
        HE(1,counter_1)=top(1,5);
        Rai(1,counter_1)=top(1,3);
        res1_1(1,counter_1)=lwupM;
        res1_2(1,counter_1)=lwupE;
        SW(1,counter_1)=bottom(1,1);
        LW(1,counter_1)=top(1,1);
        deltay(1,counter_1)=delta_y;
        deltaz(1,counter_1)=dy_current;
        ef(1,counter_1)=mean(T(:,end));
        tr(1,counter_1)=Train;
        grad_t(1,counter_1)=mean(abs((T(end,:)-T(1,:))./y(end,:)-mean((T(end,:)-T(1,:))./y(end,:))))/abs(mean((T(end,:)-T(1,:))./y(end,:)));
        aa=(T(m+1,2:n+1)-T(m,2:n+1))./(y(m+1,2:n+1)-y(m,2:n+1));
        aa1=(T(m+1,2:n+1)-mean(T(:,2:n+1)))./(y(m+1,2:n+1)/2);
        bb=(T(2,2:n+1)-T(1,2:n+1))./(y(2,2:n+1)-y(1,2:n+1));
        bb1=(mean(T(:,2:n+1))-T(1,2:n+1))./(y(m+1,2:n+1)/2);
        grad_2t(1,counter_1)=(mean(abs((bb-bb1)./bb))+ mean(abs((aa-aa1)./aa)))/2;
        grad_2t_b(1,counter_1)=mean(abs((bb-bb1)./bb));
        grad_2t_t(1,counter_1)=mean(abs((aa-aa1)./aa));
        AA1(1,counter_1)=mean(mean(A1));
        AA2(1,counter_1)=mean(mean(A2));
        AA3(1,counter_1)=mean(mean(A3));
    end
    %% check if the code is stable
    St=find(T>Tg_init+5);
    if(size(St,1)~=0)
        break;
    end
    %%
    disp('Time during rainfall in seconds (negative:stagnation layer development period):')
    disp(t)
    counter=counter+1;
end
% End of main time loop
%% After Rainfall calculations
[Tgm,res_Tgm,ev,res_h,ta,SW_a,net_rad]=after_rain(Tg,hc,rho_air,albedo,dely_air,diff_asphalt,delyg,mg,K_asphalt,cp_air,L_water,rho_rain);
%% Saving the data
date=datestr(clock,30);
save(strcat('Result/workspace-',date)) % here it save the files based on the date of the run
save(name_file) %saving the file based on the
%name_file you specify at the begining of this file