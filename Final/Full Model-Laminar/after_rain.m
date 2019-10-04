function [Tgm,res_Tgm,ev,res_h,ta,SW_a,net_rad]=after_rain(Tg,hc,rho_air,albedo,dely_air,diff_asphalt,delyg,mg,K_asphalt,cp_air,L_water,rho_rain)
Tg=Tg(end:-1:1,:);
Tgm=mean(Tg')';

[data,time,pr]=loadData_after_rain();
glob_variable(pr)
es=0.93;
SB=5.67e-8;
t_st=time(1,1);
t_end=time(1,end)-time(1,1);
dt=1;

T_temp=Tgm;
ustar=ustar_cal(data,time,dely_air);
res_Tgm=[Tgm(1,1)];
ev=[];
res_h=[];
ta=[];
SW_a=[];
net_rad=[];
global SW_down
global LW_down
global wind_speed
global air_temp

for t=t_st:dt:t_end
    
    ind=floor(t);
    SWdown=mean(data{2}(ind-15:ind+15,SW_down));
    if(SWdown<0)
        SWdown=0;
    end
    SWup=albedo*SWdown;
    SW_n=SWdown-SWup;
    LWdown=mean(data{2}(ind-15:ind+15,LW_down));
    LWup=(1-es)*LWdown+es*SB*((Tgm(1,1)+273)^4);
    LW_n=LWdown-LWup;
    ubar=mean(data{2}(ind-15:ind+15,wind_speed));
    z0=1.15e-5/(9*ustar);
    z1=dely_air;
    Ce=(0.4*0.4)/(log(z1/z0)*log(z1/z0));
    D_air=rho_air*Ce*ubar*dely_air;
    T_air=mean(data{2}(ind-15:ind+15,air_temp))+278;
    [eva_heat]=evaporation_calculator_after(Ce,rho_air,Tgm,L_water,data,ind,T_air,ubar);
    if (hc>0)
        
        hc=hc+(eva_heat*dt/L_water)/(rho_rain);
    else
        eva_heat=0;
    end
    
    
    T_temp(2:mg,1)=Tgm(2:mg,1)+dt*diff_asphalt*((Tgm((2:mg)+1,1)-2*Tgm(2:mg,1)+Tgm((2:mg)-1,1))/(delyg*delyg));
    
    T_temp(mg+1,1)=T_temp(mg,1);
    
    T_temp(1,1)=(eva_heat+SW_n+LW_n+K_asphalt*Tgm(2,1)/delyg+D_air*cp_air*(T_air-273)/dely_air)/(K_asphalt/delyg+D_air*cp_air/dely_air);
    h_temp=D_air*cp_air*(-T_temp(1,1)+T_air-273)/dely_air;
    
    Tgm=T_temp;
    disp('time after rainfall in hour:')
    disp(t/3600)
    if mod(t,1)==0
        res_Tgm=[res_Tgm mean(Tgm(1,1))];
        ev=[ev eva_heat];
        res_h=[res_h h_temp];
        ta=[ta (T_air-273)];
        SW_a=[SW_a SWdown];
        net_rad=[net_rad SW_n+LW_n];
    end
end


end