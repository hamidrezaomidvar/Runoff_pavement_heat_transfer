function [Tg_stable,res_tg,res_sw,res_airt]=ground_prof(albedo,mg,delyg,K_asphalt,cp_air,dely_air,rho_air,diff_asphalt)
mg=150;
global SW_down
global SW_up
global LW_up
global LW_down
global wind_speed
global air_temp
[data,time,pr]=loadData1();
es=0.93;
SB=5.67e-8;
t_st=time(1,1);
t_end=time(1,end);
dt=1;
Tg=(data{2}(t_st,air_temp))*ones(mg+1,1);
T_temp=Tg;
ustar=ustar_cal(data,time,dely_air);
res_tg=[];
res_sw=[];
res_airt=[];
flag=1;
j=0;
mg=100;
while flag==1
    
    ind=floor(t_st);
    
    SWdown=mean(data{2}(ind-15:ind+15,SW_down));
    if(SWdown<0)
        SWdown=0;
    end
    %SWdown=300;
    %SWup=mean(data{2}(t_st-15:t_st+15,SW_up));
    SWup=albedo*SWdown;
    SW_n=SWdown-SWup;
    LWdown=mean(data{2}(ind-15:ind+15,LW_down));
    %LWdown=400;
    %LWup=mean(data{2}(t_st-15:t_st+15,LW_up));
    LWup=(1-es)*LWdown+es*SB*((Tg(1,1)+273)^4);
    LW_n=LWdown-LWup;
    ubar=mean(data{2}(ind-15:ind+15,wind_speed));
    z0=1.15e-5/(9*ustar);
    z1=dely_air;
    Ce=(0.4*0.4)/(log(z1/z0)*log(z1/z0));
    D_air=1.2*Ce*ubar*dely_air;
    T_air=mean(data{2}(ind-15:ind+15,air_temp));
    
    T_temp(2:mg,1)=Tg(2:mg,1)+dt*diff_asphalt*((Tg((2:mg)+1,1)-2*Tg(2:mg,1)+Tg((2:mg)-1,1))/(delyg*delyg));
    
    T_temp(mg+1,1)=T_temp(mg,1);
    
    T_temp(1,1)=(SW_n+LW_n+K_asphalt*Tg(2,1)/delyg+D_air*cp_air*T_air/dely_air)/(K_asphalt/delyg+D_air*cp_air/dely_air);
    
    if mod(j,5*60/dt)==0
        if j==0
            Ttmp=T_temp;
        else
            errt=sum(abs(Ttmp-T_temp)) ;
            Ttmp=T_temp;
            if errt<=0.01
                flag=0;
            end
            disp(errt)
        end
        
    end
    
    
    Tg=T_temp;
    j=j+1;
end



for t=t_st:dt:t_end
    
    ind=floor(t);
    
    SWdown=mean(data{2}(ind-15:ind+15,SW_down));
    if(SWdown<0)
        SWdown=0;
    end
    %SWdown=300;
    %SWup=mean(data{2}(t_st-15:t_st+15,SW_up));
    SWup=albedo*SWdown;
    SW_n=SWdown-SWup;
    LWdown=mean(data{2}(ind-15:ind+15,LW_down));
    %LWdown=400;
    %LWup=mean(data{2}(t_st-15:t_st+15,LW_up));
    LWup=(1-es)*LWdown+es*SB*((Tg(1,1)+273)^4);
    LW_n=LWdown-LWup;
    ubar=mean(data{2}(ind-15:ind+15,wind_speed));
    z0=1.15e-5/(9*ustar);
    z1=dely_air;
    Ce=(0.4*0.4)/(log(z1/z0)*log(z1/z0));
    D_air=1.2*Ce*ubar*dely_air;
    T_air=mean(data{2}(ind-15:ind+15,air_temp));
    
    T_temp(2:mg,1)=Tg(2:mg,1)+dt*diff_asphalt*((Tg((2:mg)+1,1)-2*Tg(2:mg,1)+Tg((2:mg)-1,1))/(delyg*delyg));
    
    T_temp(mg+1,1)=T_temp(mg,1);
    
    T_temp(1,1)=(SW_n+LW_n+K_asphalt*Tg(2,1)/delyg+D_air*cp_air*T_air/dely_air)/(K_asphalt/delyg+D_air*cp_air/dely_air);
    %{
    if mod(j,5*60/dt)==0
        if j==0
            Ttmp=T_temp;
        else
            errt=sum(abs(Ttmp-T_temp)) ;
            Ttmp=T_temp;
            if errt<=0.001
                flag=0;
            end
            disp(errt)
        end
        
    end
    %}
    
    Tg=T_temp;
    disp(t)
    if mod(t,1)==0
        res_tg=[res_tg mean(Tg(1,1))];
        res_sw=[res_sw SW_n];
        res_airt=[res_airt T_air];
    end
end
Tg_stable=Tg;

end