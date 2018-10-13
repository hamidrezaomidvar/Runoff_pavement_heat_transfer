function [G1]=Radiation_ground(albedo,data,time,t)
i=ceil(t);
global SW_down
global SW_up

%a=0*(data{1}(i,SW_down));
%a=100;
G1=(data{1}(i,SW_down))-albedo*(data{1}(i,SW_down));
%G1=a-albedo*a;
%G1=263*(1-.12);

end