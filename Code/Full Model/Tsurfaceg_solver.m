function [T,Tg,G1]=Tsurfaceg_solver(albedo,DFlow,rho_rain,cp_water,T_1,det,ety,Tg_1,delyg,K_asphalt,K_water,mg,Tg,T,data,time,t,rr)
[G1]=Radiation_ground(albedo,data,time,t);
T(1,:)=(G1+((DFlow(2,:)*rho_rain*cp_water).*ety(2,:).*T_1(2,:)/det)+(K_asphalt*Tg_1(mg,:)/(delyg)))./(((DFlow(2,:)*rho_rain*cp_water).*ety(2,:)/det)+(K_asphalt/(delyg)));
Tg(mg+1,:)=T(1,:);
end 