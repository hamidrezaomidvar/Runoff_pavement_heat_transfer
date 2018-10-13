function [albedo,dely_air,rho_air,cp_air,DWater_Molecular,mg,m,n,s,I,g,kin_vis,L_water,l,delt_heat,t_tot_heat,K_asphalt,K_water,K_air,rho_asphalt,cp_asphalt,Ta,Train,Tg_init,rho_rain,cp_water,relative_humid]=Properties(time,pr)
albedo=0.05;
s=0.0010;
g=9.8;
kin_vis=10^-6;
DWater_Molecular=4*0.143e-6;
L_water=2453000;
K_asphalt=1.2;
K_water=0.58;
K_air=0.024;
rho_asphalt=2238;
rho_rain=1000;
rho_air=1.2;
cp_water=4185;
cp_asphalt=900;
cp_air=1005;
Tg_init=cell2mat(pr(1,6));
Ta=273+25;
global rain_temp
Train=rain_temp;
relative_humid=0.6;
l=10;
I=30/(3600*1000);
dely_air=cell2mat(pr(1,5))/100;
%% time & step
delt_heat=1;
%t_tot_heat=time(1,end)-time(1,1);
t_tot_heat=3*60*60;
%% mesh size
%mg=52;
mg=ceil((((t_tot_heat)/(.5*3600))^.5)*52);
m=2;
n=30;
end