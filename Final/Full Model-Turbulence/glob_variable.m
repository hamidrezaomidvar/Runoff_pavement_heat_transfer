function glob_variable(pr)
global SW_up
global SW_down
global LW_up
global LW_down
global R_humidity
global rain_temp
global air_temp
global wind_speed
global pressure
global spec_h
SW_up=1;
SW_down=2;
LW_up=3;
LW_down=4;
R_humidity=10;
rain_temp=cell2mat(pr(1,12));
air_temp=7;
wind_speed=8;
pressure=9;
spec_h=11;
end
