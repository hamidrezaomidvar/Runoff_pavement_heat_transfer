function [diff_asphalt,delyg]=Ground_properties(K_asphalt,rho_asphalt,cp_asphalt,t_tot_heat,mg)

diff_asphalt=K_asphalt/(rho_asphalt*cp_asphalt);
depth=5*((diff_asphalt*t_tot_heat)^.5);
delyg=depth/mg;

end