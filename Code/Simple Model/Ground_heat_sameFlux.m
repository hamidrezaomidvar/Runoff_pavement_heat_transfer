function [Tsub_s]=Ground_heat_sameFlux(Tsub_s,delt_heat,diff_asphalt,delyg)
T_temp_2=Tsub_s;
T_temp_2(2:end-1,1)=Tsub_s(2:end-1,1)+delt_heat*diff_asphalt*(((Tsub_s((2:end-1)+1,1)-2*Tsub_s(2:end-1,1)+Tsub_s((2:end-1)-1,1))/(delyg*delyg)));
T_temp_2(1,1)=T_temp_2(2,1);
Tsub_s=T_temp_2;

end