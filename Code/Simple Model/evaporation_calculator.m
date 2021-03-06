function [eva_heat_2,Dair_turbulent_2]=evaporation_calculator(Ts_s,rho_air,dely_air,L_water,data,t,ustar)
i=ceil(t);
a0=6984.505294;
a1=-188.9039310;
a2=2.133357675;
a3=-1.288580973e-2;
a4=4.393587233e-5;
a5=-8.023923082e-8;
a6=6.136820929e-11;


T_temp=Ts_s+273;

es_w_2=100*(a0+T_temp.*(a1+T_temp.*(a2+T_temp.*(a3+T_temp.*(a4+T_temp.*(a5+a6.*T_temp))))));

global air_temp
global R_humidity
%R_humidity=relative_humid;
global wind_speed
global pressure
global spec_h;
T_air=data{2}(i,air_temp)+273;
es_a=100*(a0+T_air*(a1+T_air*(a2+T_air*(a3+T_air*(a4+T_air*(a5+a6*T_air))))))*data{2}(i,R_humidity)/100;
rho_v_1_2=(0.622*es_w_2)./(287.04*T_temp);

rho_v_2=(0.622*es_a*data{2}(i,R_humidity)/100)./(287.04*(25+273));
rho_d_1_2=(100*data{2}(i,pressure)-es_w_2)./(287.04*T_temp);
rho_d_2=(1e5-es_a*data{2}(i,R_humidity)/100)./(287.04*(25+273));
rho_1_2=rho_v_1_2+rho_d_1_2;
rho_2=rho_v_2+rho_d_2;
q1_2=rho_v_1_2./rho_1_2;
q2=rho_v_2./rho_2;
q2=data{2}(i,spec_h);

ubar=mean(data{2}(i-15:i+15,wind_speed));
z0=1.15e-5/(9*ustar);
z1=dely_air;
Ce=(0.4*0.4)/(log(z1/z0)*log(z1/z0));


eva_heat_2=Ce*rho_air.*ubar.*(q2-q1_2).*L_water;
Dair_turbulent_2=eva_heat_2*dely_air./(L_water*(q2-q1_2));

end