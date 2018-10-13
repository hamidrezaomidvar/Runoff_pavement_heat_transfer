function [diff_asphalt,delyg,Tg]=Ground_properties(K_asphalt,rho_asphalt,cp_asphalt,t_tot_heat,n,Tg_init,mg)

diff_asphalt=K_asphalt/(rho_asphalt*cp_asphalt);
depth=5*((diff_asphalt*t_tot_heat)^.5);
delyg=depth/mg;
Tg=Tg_init*ones(mg+1,n+1);

for i=1:mg+1
    delT=Tg_init-42;
    hm=7.62/100;
    a=(-log((Tg_init-delT)/(Tg_init)))*(((mg)*delyg+(hm-depth))^-1);
    Tg(i,:)=(Tg_init)*exp(-a*(mg*delyg-(i-1)*delyg));
    
end


end