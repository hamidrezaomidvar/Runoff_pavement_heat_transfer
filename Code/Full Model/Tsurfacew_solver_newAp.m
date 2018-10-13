function [LW,lwupM,lwupE,lw,T,eva_heat,Dair_turbulent,B]=Tsurfacew_solver_newAp(dely_air,n,n1,rho_air,cp_air,DFlow,ety,T_1,T,m,det,rho_rain,cp_water,I,Train,L_water,data,t,ustar)
es=0.96;
SB=5.67e-8;
%ea=0.7+5.95*(10^-5)*(3.17)*exp(1500/Ta);
%Fc=.5;
%alpha_a=ea*SB*(1+.4*Fc*Fc);
%alpha_s=es*SB;
%Ta_pr=((alpha_a/alpha_s)^.25)*Ta;
%A=alpha_s*(Ta_pr+(T_1(m+1,:)+273)).*(Ta_pr^2+(T_1(m+1,:)+273).^2);
B=I*rho_rain*cp_water;

[eva_heat,Dair_turbulent]=evaporation_calculator(rho_air,m,T_1,dely_air,L_water,data,t,ustar);

i=ceil(t);
global LW_up
global LW_down

LW=data{1}(i,LW_down)-(1-es)*data{1}(i,LW_down)-es*SB*(((T_1(m+1,:)+273)).^4);
lw=mean(LW);
lwupM=mean((1-es)*data{1}(i,LW_down)+es*SB*(((T_1(m+1,:)+273)).^4));
lwupE=data{1}(i,LW_up);

global air_temp
T_air=data{2}(i,air_temp)+273;


T(m+1,1:n1+1)=(eva_heat(1,1:n1+1)+B*(Train+273)+(LW(1,1:n1+1))+((Dair_turbulent(1,1:n1+1)*cp_air).*T_air/dely_air)+((DFlow(m,1:n1+1)*rho_rain*cp_water).*(T_1(m,1:n1+1)+273).*ety(m,1:n1+1)/det))./(B+((Dair_turbulent(1,1:n1+1)*cp_air)/dely_air)+((DFlow(m,1:n1+1)*rho_rain*cp_water).*ety(m,1:n1+1)/det));
T(m+1,n1+2:n+1)=(eva_heat(1,n1+2:n+1)+B*(Train+273)+(LW(1,n1+2:n+1))+((Dair_turbulent(1,n1+2:n+1)*cp_air).*T_air/dely_air)+((DFlow(m,n1+2:n+1)*rho_rain*cp_water).*(T_1(m,n1+2:n+1)+273).*ety(m,n1+2:n+1)/det))./(B+((Dair_turbulent(1,n1+2:n+1)*cp_air)/dely_air)+((DFlow(m,n1+2:n+1)*rho_rain*cp_water).*ety(m,n1+2:n+1)/det));

T(m+1,:)=T(m+1,:)-273;



end