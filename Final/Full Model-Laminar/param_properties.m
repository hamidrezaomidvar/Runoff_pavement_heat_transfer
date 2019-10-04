function [albedo,dely_air,rho_air,cp_air,DWater_Molecular,mg,m,n,s,I,g,kin_vis,L_water,l,delt_heat,t_tot_heat,K_asphalt,K_water,K_air,rho_asphalt,cp_asphalt,rho_rain,cp_water]=param_properties(time,pr)
albedo=0.05;
s=0.0019;
g=9.8;
kin_vis=10^-6;
DWater_Molecular=3*0.143e-6;
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
l=200;
I=100/(3600*1000);
dely_air=cell2mat(pr(1,5))/100; % vertical distance where the air properties are measured
%% time & step
delt_heat=(.2)*1e-3;
%t_tot_heat=time(1,end)-time(1,1); %if you specify the rain duration in the
%file
t_tot_heat=3*60*60;
%% mesh size
%mg=52;
mg=ceil((((((K_asphalt/(rho_asphalt*cp_asphalt))/(1.2/(2238*900)))*t_tot_heat)/(.5*3600))^.5)*52); % if you like to be consistant with grid convergence tests
m=5;
n=30;
end