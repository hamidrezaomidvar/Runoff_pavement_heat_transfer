function [Tr_s,bot,top_2,right]=Flow_heat_sameFlux(l,vel_prof,dhdt,rr,depth_h_old,Train,depth_h,I,Tr_s,Ts_s,Tsub_s,x,y,m,n,DFlow,delt_heat)
Dw=DFlow(1,1);
h=depth_h;
ho=depth_h_old;
bot=(Dw*(Tsub_s(end,1)-Tr_s)/(((ho))/2));
top_2=(Dw*(Ts_s-Tr_s)/(((ho))/2));
%right=((I-((h-ho)/delt_heat))*(Ts_s-Tr_s));

right=I*(Ts_s)-(I-((h-ho)/delt_heat))*(Tr_s);
%right=I*(Ts_s+273)-((y(end,end)/l)*mean(vel_prof(:,end)))*(Tr_s+273);
%Tr_s=(1/((h+ho)/2))*(((h+ho)/2)*(Tr_s)+delt_heat*(bot+top_2+right));

Tr_s=(1/(h))*((ho)*(Tr_s)+delt_heat*(bot+top_2+right));


end