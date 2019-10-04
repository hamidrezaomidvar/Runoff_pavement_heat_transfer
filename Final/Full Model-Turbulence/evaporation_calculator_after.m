function [eva_heat]=evaporation_calculator_after(Ce,rho_air,Tg,L_water,data,i,T_air,ubar)
a0=6984.505294;
a1=-188.9039310;
a2=2.133357675;
a3=-1.288580973e-2;
a4=4.393587233e-5;
a5=-8.023923082e-8;
a6=6.136820929e-11;

Tsw_K=Tg(1,1)+273;

es_w=100*(a0+Tsw_K.*(a1+Tsw_K.*(a2+Tsw_K.*(a3+Tsw_K.*(a4+Tsw_K.*(a5+a6.*Tsw_K))))));

global R_humidity
global pressure
global spec_h

es_a=100*(a0+T_air*(a1+T_air*(a2+T_air*(a3+T_air*(a4+T_air*(a5+a6*T_air))))))*data{2}(i,R_humidity)/100;
rho_v_1=(0.622*es_w)./(287.04*Tsw_K);


rho_v_2=(0.622*es_a*data{2}(i,R_humidity)/100)./(287.04*(25+273));
rho_d_1=(100*data{2}(i,pressure)-es_w)./(287.04*Tsw_K);
rho_d_2=(1e5-es_a*data{2}(i,R_humidity)/100)./(287.04*(25+273));
rho_1=rho_v_1+rho_d_1;
rho_2=rho_v_2+rho_d_2;
q1=rho_v_1./rho_1;
q2=rho_v_2./rho_2;
q2=data{2}(i,spec_h);

eva_heat=Ce*rho_air.*ubar.*(q2-q1).*L_water; 





end