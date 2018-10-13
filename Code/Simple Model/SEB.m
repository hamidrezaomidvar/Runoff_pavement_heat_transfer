function [top,bottom]=SEB(Tr_s,Dair_turbulent_2,depth_h,Ts_s,eva_heat_2,LW_2,Tsub_s,cp_air,dely_air,Train,B,m,G1,DFlow,rho_rain,cp_water,delyg,K_asphalt,data,t)

%% Bottom
flux_rad_bottom=G1;
flux_StoW=mean((DFlow(2,:)*rho_rain*cp_water).*(Tr_s-Tsub_s(end,1))/(depth_h/2));
flux_GtoS=mean(K_asphalt*(Tsub_s(end-1,1)-Tsub_s(end,1))/(delyg));
flux_sum_bottom=flux_rad_bottom+flux_StoW+flux_GtoS;
bottom=[flux_rad_bottom flux_StoW flux_GtoS flux_sum_bottom];
%% top
i=ceil(t);
flux_rad_top=LW_2;
flux_LE=eva_heat_2;
flux_rain=B*(Train-Ts_s);
flux_WtoS=(mean(DFlow(m,:))*rho_rain*cp_water).*(Tr_s-Ts_s)./(depth_h/2);
global air_temp
T_air=data{2}(i,air_temp);
flux_H=(Dair_turbulent_2*cp_air).*((T_air)-Ts_s)/dely_air;
flux_sum_top=flux_rad_top+flux_WtoS+flux_H+flux_LE+flux_rain;
top=[flux_rad_top flux_LE flux_rain flux_WtoS flux_H flux_sum_top];
end