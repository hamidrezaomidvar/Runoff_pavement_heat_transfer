function [G1]=Radiation_ground(albedo,data,time,t)
i=ceil(t);
global SW_down
global SW_up


%G1=(data{1}(i,SW_down))-data{1}(i,SW_up);
G1=(data{1}(i,SW_down))-albedo*(data{1}(i,SW_down));
%G1=263*(1-.12);


end