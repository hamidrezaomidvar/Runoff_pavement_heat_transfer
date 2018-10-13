function [Tsub_s,G1]=Tsurfaceg_updator(depth_h,Tr_s,Tsub_s,y,albedo,DFlow,rho_rain,cp_water,mg,delyg,K_asphalt,data,time,t)
[Tsub_s,G1]=Tsurfaceg_solver(depth_h,Tr_s,Tsub_s,y,albedo,DFlow,rho_rain,cp_water,delyg,K_asphalt,mg,data,time,t);
end