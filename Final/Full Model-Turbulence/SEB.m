function [top,bottom,eva_heat,rain_heat,heat_w_ws,heat_H]=SEB(lw,T_1,Tg_1,cp_air,dely_air,Train,eva_heat,Dair_turbulent,B,mg,m,G1,DFlow,rho_rain,cp_water,T,Tg,delyg,det,ety,K_asphalt,data,t)

%% Bottom
flux_rad_bottom=G1;
flux_StoW=mean((DFlow(2,:)*rho_rain*cp_water).*ety(2,:).*(T_1(2,:)-T(1,:))/det);
flux_GtoS=mean(K_asphalt*(Tg_1(mg,:)-Tg(mg+1,:))/(delyg));
flux_sum_bottom=flux_rad_bottom+flux_StoW+flux_GtoS;
bottom=[flux_rad_bottom flux_StoW flux_GtoS flux_sum_bottom];
%% top
i=ceil(t);

flux_rad_top=lw;
flux_LE=mean(eva_heat);
rain_heat=B*(Train-T(m+1,:));
flux_rain=mean(rain_heat);
heat_w_ws=(DFlow(m,:)*rho_rain*cp_water).*(T_1(m,:)-T(m+1,:)).*ety(m,:)/det;
flux_WtoS=mean(heat_w_ws);
global air_temp
T_air=data{2}(i,air_temp);
heat_H=(Dair_turbulent(1,:)*cp_air).*((T_air)-T(m+1,:))/dely_air;
flux_H=mean(heat_H);
flux_sum_top=flux_rad_top+flux_WtoS+flux_H+flux_LE+flux_rain;
top=[flux_rad_top flux_LE flux_rain flux_WtoS flux_H flux_sum_top];
end