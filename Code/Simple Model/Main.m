clear
clc
close all
clear global variable
%%
%%%getting data from files and declaring the global variables
[data,time,pr]=loadData();
glob_variable(pr)

%%%getting the properties of the simulation
[albedo,dely_air,rho_air,cp_air,DWater_Molecular,mg,m,n,s,I,g,kin_vis,L_water,l,delt_heat,t_tot_heat,K_asphalt,K_water,K_air,rho_asphalt,cp_asphalt,Ta,Train,Tg_init,rho_rain,cp_water,relative_humid]=Properties(time,pr);

%%% variables vectors
y=zeros(m+1,n+1);
x=zeros(m+1,n+1);
yq=zeros(m+1,n+1);
xq=zeros(m+1,n+1);
yg=zeros(mg+1,n+1);
xg=zeros(mg+1,n+1);
yqg=zeros(mg+1,n+1);
xqg=zeros(mg+1,n+1);
hq_top=0;
%%% if dynamic is in steady state or not. It is not at the begining and
%%% then it changes to 1
steadyState=0;
%% depth of the inital layer
hc=.5/1000;
hc0=.1/1000;
t_start=-((hc-hc0)/I);
Ir=I;
I=I*((hc-hc0)/I)/(-t_start);
%% calcualtion of subsurface properties and variables
[diff_asphalt,delyg,Tg]=Ground_properties(K_asphalt,rho_asphalt,cp_asphalt,t_tot_heat,n,Tg_init,mg);
%%%before rainfal calculations to get the initial condition of the
%%%subsurface
[Tg_stable,res_tg,res_sw,res_airt]=ground_prof(albedo,mg,delyg,K_asphalt,cp_air,dely_air,rho_air,diff_asphalt);
Tg_init=Tg_stable(1,1);
[T]=temp_properties(Train,m,n,Tg_init,hc,DWater_Molecular,I);

for i=1:mg+1
    Tg(i,:)=Tg_stable(mg+1-(i-1),1);
    
end
%% ustar calculation
ustar=ustar_cal(data,time,dely_air);
%% heat
%% specifying the frequency of outputs
counter=0;
f=1;
num=ceil(f/delt_heat);
f2=5;
num2=ceil(f2/delt_heat);
f1=60;
num1=ceil(f1/delt_heat);
filename = 'Result/Result.gif';
flag=1;
EVAP=zeros(1,t_tot_heat);
GR=zeros(1,t_tot_heat);
GS_W=zeros(1,t_tot_heat);
W_WS=zeros(1,t_tot_heat);
HE=zeros(1,t_tot_heat);
Rai=zeros(1,t_tot_heat);
SW=zeros(1,t_tot_heat);
LW=zeros(1,t_tot_heat);
s_s=zeros(1,t_tot_heat);
r_s=zeros(1,t_tot_heat);
sub_s=zeros(1,t_tot_heat);
ts_top_2=zeros(1,t_tot_heat);
ts_bot=zeros(1,t_tot_heat);
ts_right=zeros(1,t_tot_heat);



indx=1;

counter_1=0;

count_dyn=-1;
delt_heat_tmp=delt_heat;
multy=1;
cte=0;
%%
Tr_s=T(1,1);
Tg_s=T(1,1);
Ts_s=T(1,1);
Tsub_s(:,1)=Tg(:,1);
%%
tic
for t=t_start:delt_heat:t_tot_heat+t_start
    %%%check if the runoff is started t<0 development of initial layer
    if(t<0)
        hc=hc0+I*(t-t_start);
    else
        if count_dyn==-1
            counter=0;
        end
        I=Ir;
        count_dyn=count_dyn+1;
        t=t+count_dyn*(multy-1)*delt_heat_tmp;
        delt_heat=multy*delt_heat_tmp;
        num=ceil(f/delt_heat);
        num2=ceil(f2/delt_heat);
    end
    if t>t_tot_heat+t_start
        break;
    end
    
    ind=t+cell2mat(pr(1,14))-t_start;
    ff=ceil(ind);
    Train=data{1}(ff,7);
    if(steadyState==0)
        %this dynamic part of the model is not related in the simple model
        [x,y,T,n1,h_top,xq,yq,hq_top,steadyState]=inter_mesh(hc,g,kin_vis,t,t_start,I,s,n,m,x,y,T,l,xq,yq,hq_top,steadyState);
        [xg,xqg,yg,yqg,Tg]=ground_mesh(xg,xqg,yg,yqg,Tg,x,n,mg,t_start,t,delyg);
        Tg(mg+1,:)=T(1,:);
        [ety,xix,etx,det,dxi]=Transfer_mesh(t,hc,m,s,I,x,y,n1,h_top,n,l,g,kin_vis);
        [DFlow,DFlow_y]=diffusivity(m,n,DWater_Molecular);
        [ vel_prof ,vel_prof_y]=Velocity_Profile(t,hc,x,y,s,g,I,n,m,kin_vis);
    end
    
    depth_h=mean(y(end,:));
    
    if t==t_start
    depth_h_old=mean(y(end,:));
    depth_temp=y(end,end);
    end
    dhdt=(y(end,end)-depth_temp)/delt_heat;
    %% Main heat calculations of the model
    [top,bottom,Tr_s,Tg_s,Ts_s,Tsub_s,bot,top_2,right]=Heat(l,vel_prof,dhdt,depth_h_old,depth_h,Tr_s,Tg_s,Ts_s,Tsub_s,x,albedo,dely_air,n1,diff_asphalt,delyg,rho_air,cp_air,y,mg,m,n,DFlow,L_water,I,delt_heat,K_asphalt,Ta,Train,rho_rain,cp_water,data,t-t_start,ind,t,ustar);
    %%
    depth_h_old=mean(y(end,:));
    depth_temp=y(end,end);
    %% saving some outputs
    if(mod(counter,num)==0)
        counter_1=counter_1+1;
        EVAP(1,counter_1)=top(1,2);
        GR(1,counter_1)=bottom(1,3);
        GS_W(1,counter_1)=bottom(1,2);
        W_WS(1,counter_1)=top(1,4);
        HE(1,counter_1)=top(1,5);
        Rai(1,counter_1)=top(1,3);
        SW(1,counter_1)=bottom(1,1);
        LW(1,counter_1)=top(1,1);
        s_s(1,counter_1)=Ts_s;
        r_s(1,counter_1)=Tr_s;
        sub_s(1,counter_1)=Tsub_s(end,1);
        ts_top_2(1,counter_1)=top_2;
        ts_bot(1,counter_1)=bot;
        ts_right(1,counter_1)=right;
    end
    %.............................................
    %% check if the code is unstable or not
    St=find(T>Tg_init+5);
    if(size(St,1)~=0)
        break;
    end
    disp(t)
    
    counter=counter+1;
end
%% Saving the data based on the time and date of the run
date=datestr(clock,30);
save(strcat('Result/workspace-',date))
toc