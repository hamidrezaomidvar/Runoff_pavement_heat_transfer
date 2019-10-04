function ustar=ustar_cal(data,time,dely_air)

global wind_speed
ubar=mean(data{2}(time(1,1):time(1,end),wind_speed));

fun=@(x)(x/0.4)*(log(dely_air*x/(9*1.15e-5)))-ubar;
ustar=fsolve(fun,0.1);


end