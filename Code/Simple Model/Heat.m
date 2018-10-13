function  [top,bottom,Tr_s,Tg_s,Ts_s,Tsub_s,bot,top_2,right]=Heat(l,vel_prof,dhdt,depth_h_old,depth_h,Tr_s,Tg_s,Ts_s,Tsub_s,x,albedo,dely_air,n1,diff_asphalt,delyg,rho_air,cp_air,y,mg,m,n,DFlow,L_water,I,delt_heat,K_asphalt,Ta,Train,rho_rain,cp_water,data,time,t,rr,ustar)

%% flow
hm=depth_h;
[Tr_s,bot,top_2,right]=Flow_heat_sameFlux(l,vel_prof,dhdt,rr,depth_h_old,Train,depth_h,I,Tr_s,Ts_s,Tsub_s,x,y,m,n,DFlow,delt_heat);
[Ts_s,eva_heat_2,Dair_turbulent_2,B,LW_2]=Tsurfacew_updator(hm,Tr_s,Ts_s,dely_air,n,n1,rho_air,cp_air,DFlow,m,Ta,rho_rain,cp_water,I,Train,y,L_water,data,t,rr,ustar);
%% ground
[Tsub_s]=Ground_heat_sameFlux(Tsub_s,delt_heat,diff_asphalt,delyg);
[Tsub_s,G1]=Tsurfaceg_updator(hm,Tr_s,Tsub_s,y,albedo,DFlow,rho_rain,cp_water,mg,delyg,K_asphalt,data,time,t);
%%SEB
[top,bottom]=SEB(Tr_s,Dair_turbulent_2,hm,Ts_s,eva_heat_2,LW_2,Tsub_s,cp_air,dely_air,Train,B,m,G1,DFlow,rho_rain,cp_water,delyg,K_asphalt,data,t);

end