function [T,Tg,G1]=Tsurfaceg_updator(albedo,DFlow,rho_rain,cp_water,Tg_1,mg,T_1,det,delyg,K_asphalt,K_water,ety,Tg,T,data,time,t,rr)
[T,Tg,G1]=Tsurfaceg_solver(albedo,DFlow,rho_rain,cp_water,T_1,det,ety,Tg_1,delyg,K_asphalt,K_water,mg,Tg,T,data,time,t,rr);
end