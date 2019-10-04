function  [A1,A2,A3,LW,lwupM,lwupE,T,Tg,top,bottom,eva_heat,rain_heat,heat_w_ws,heat_H]=Heat(x,y_old,albedo,vel_prof_y,dely_air,n1,T,ety,xix,etx,diff_asphalt,delyg,xg,Tg,rho_air,cp_air,y,mg,m,n,dxi,det,DFlow,DFlow_y,L_water,I,vel_prof,delt_heat,K_asphalt,K_water,Train,rho_rain,cp_water,data,time,t,rr,ustar)
T_1=T;
%% runoff equations
[T,A1,A2,A3]=Flow_heat_sameFlux(x,y,y_old,vel_prof_y,m,n,dxi,det,DFlow,DFlow_y,vel_prof,delt_heat,T,ety,xix,etx);
%% Top BC surface energy budget
[LW,lwupM,lwupE,lw,T,eva_heat,Dair_turbulent,B]=Tsurfacew_updator(dely_air,n,n1,rho_air,cp_air,DFlow,ety,m,T_1,T,det,rho_rain,cp_water,I,Train,L_water,data,t,ustar);
%%
Tg_1=Tg;
%% subsurface equations
[Tg]=Ground_heat_sameFlux(n,mg,delt_heat,diff_asphalt,xg,Tg,delyg,dxi,xix);
%% Bottom surface energy budget
[T,Tg,G1]=Tsurfaceg_updator(albedo,DFlow,rho_rain,cp_water,Tg_1,mg,T_1,det,delyg,K_asphalt,K_water,ety,Tg,T,data,time,t,rr);
%% Some SEB calculations and outputs
[top,bottom,eva_heat,rain_heat,heat_w_ws,heat_H]=SEB(lw,T_1,Tg_1,cp_air,dely_air,Train,eva_heat,Dair_turbulent,B,mg,m,G1,DFlow,rho_rain,cp_water,T,Tg,delyg,det,ety,K_asphalt,data,t);
end