function [Tsub_s,G1]=Tsurfaceg_solver(depth_h,Tr_s,Tsub_s,y,albedo,DFlow,rho_rain,cp_water,delyg,K_asphalt,mg,data,time,t)
[G1]=Radiation_ground(albedo,data,time,t);

h=depth_h;
Tsub_s(end)=((G1+((mean(DFlow(2,:))*rho_rain*cp_water).*Tr_s)/(h/2))+(K_asphalt*(Tsub_s(mg,1)/(delyg))))./(((mean(DFlow(2,:))*rho_rain*cp_water)./(h/2))+(K_asphalt/(delyg)));

end 