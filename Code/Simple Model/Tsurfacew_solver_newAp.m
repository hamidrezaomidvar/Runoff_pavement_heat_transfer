function [Ts_s,eva_heat_2,Dair_turbulent_2,B,LW_2]=Tsurfacew_solver_newAp(depth_h,Tr_s,Ts_s,dely_air,n,n1,rho_air,cp_air,DFlow,m,Ta,rho_rain,cp_water,I,Train,y,L_water,data,t,rr,ustar)
es=0.96;
SB=5.67e-8;
ea=0.7+5.95*(10^-5)*(3.17)*exp(1500/Ta);
Fc=.5;


alpha_a=ea*SB*(1+.4*Fc*Fc);
alpha_s=es*SB;
Ta_pr=((alpha_a/alpha_s)^.25)*Ta;
B=I*rho_rain*cp_water;

[eva_heat_2,Dair_turbulent_2]=evaporation_calculator(Ts_s,rho_air,dely_air,L_water,data,t,ustar);

i=ceil(t);

global LW_down

LW_2=data{1}(i,LW_down)-(1-es)*data{1}(i,LW_down)-es*SB*((mean((Ts_s+273))).^4);

global air_temp
T_air=data{2}(i,air_temp)+273;
if(rr<0)
   %B=0; 
end

h=depth_h;
tmp_2=(eva_heat_2+B*(Train+273)+(LW_2)+((Dair_turbulent_2*cp_air).*T_air/dely_air)+((mean(DFlow(m,1:n1+1))*rho_rain*cp_water).*(Tr_s+273)./(h/2)))./(B+((Dair_turbulent_2*cp_air)/dely_air)+((mean(DFlow(m,1:n+1))*rho_rain*cp_water)./(h/2)));

Ts_s=tmp_2;
Ts_s=Ts_s-273;


end