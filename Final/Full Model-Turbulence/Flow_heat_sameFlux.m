function [T,A1,A2,A3]=Flow_heat_sameFlux(x,y,y_old,vel_prof_y,m,n,dxi,det,DFlow,DFlow_y,vel_prof,delt_heat,T,ety,xix,etx)
%{
T_temp=T;
T_temp(2:m,2:n)=T(2:m,2:n)+delt_heat*(((-ety(2:m,2:n)).*(vel_prof_y(2:m,2:n)).*((T((2:m)+1,2:n)-T((2:m)-1,2:n))./(2*det)))+DFlow(2:m,2:n).*(ety(2:m,2:n).^2).*((T((2:m)+1,2:n)-2*T(2:m,2:n)+T((2:m)-1,2:n))./(det^2))+(DFlow_y(2:m,2:n)).*(ety(2:m,2:n)).*((T((2:m)+1,2:n)-T((2:m)-1,2:n))./(2*det))-(etx(2:m,2:n)).*(((vel_prof(2:m,2:n).*T((2:m)+1,2:n))-(vel_prof(2:m,2:n).*T((2:m),2:n)))./(det))-(xix(2:m,2:n)).*(((vel_prof(2:m,2:n).*T(2:m,(2:n)))-(vel_prof(2:m,2:n).*T(2:m,(2:n)-1)))./(dxi)));
T_temp(2:m,1)=T(2:m,1)+delt_heat*(((-ety(2:m,1)).*(vel_prof_y(2:m,1)).*((T((2:m)+1,1)-T((2:m)-1,1))./(2*det)))+DFlow(2:m,1).*(ety(2:m,1).^2).*((T((2:m)+1,1)-2*T(2:m,1)+T((2:m)-1,1))./(det^2))+(DFlow_y(2:m,1)).*(ety(2:m,1)).*((T((2:m)+1,1)-T((2:m)-1,1))./(2*det))-(etx(2:m,2)).*(((vel_prof(2:m,1).*T((2:m)+1,1))-(vel_prof(2:m,1).*T((2:m),1)))./(det))-(xix(2:m,1)).*(((vel_prof(2:m,1).*T(2:m,(2)))-(vel_prof(2:m,1).*T(2:m,(2)-1)))./(dxi)));
%T_temp(2:m,n+1)=T(2:m,n+1)+delt_heat*(((-ety(2:m,n+1)).*(vel_prof_y(2:m,n+1)).*((T((2:m)+1,n+1)-T((2:m)-1,n+1))./(2*det)))+DFlow(2:m,n+1).*(ety(2:m,n+1).^2).*((T((2:m)+1,n+1)-2*T(2:m,n+1)+T((2:m)-1,n+1))./(det^2))+(DFlow_y(2:m,n+1)).*(ety(2:m,n+1)).*((T((2:m)+1,n+1)-T((2:m)-1,n+1))./(2*det))-(etx(2:m,n+1)).*(((vel_prof(2:m,n+1).*T((2:m)+1,n+1))-(vel_prof(2:m,n+1).*T((2:m),n+1)))./(det))-(xix(2:m,n+1)).*(((vel_prof(2:m,n+1).*T(2:m,(n+1)))-(vel_prof(2:m,n+1).*T(2:m,(n))))./(dxi)));
T_temp(2:m,n+1)=2*T_temp(2:m,n)-T_temp(2:m,n-1);
T=T_temp;
%}


vel_mesh=(y-y_old)./delt_heat;
T_temp=T;
%T_temp(2:m,1:n)=T(2:m,1:n)+delt_heat*((vel_mesh(2:m,1:n)).*((T((2:m)+1,1:n)-T((2:m)-1,1:n))./(y((2:m)+1,1:n)-y((2:m)-1,1:n)))+((DFlow(2:m,1:n)).*((((T((2:m)+1,1:n)-T(2:m,1:n))./(y((2:m)+1,1:n)-y(2:m,1:n)))-((T(2:m,1:n)-T((2:m)-1,1:n))./(y(2:m,1:n)-y((2:m)-1,1:n))))./(y(2:m,1:n)-y((2:m)-1,1:n))))-((vel_prof_y(2:m,1:n)).*((y((2:m)+1,1:n)-y((2:m)-1,1:n))./(y((2:m)+1,1:n)-y((2:m)-1,1:n))))-(((x(2:m,(1:n)+1)-x(2:m,1:n))./(((x(2:m,(1:n)+1)-x(2:m,1:n)).^2+(y(2:m,(1:n)+1)-y(2:m,1:n)).^2).^.5)).*(vel_prof(2:m,1:n)).*((T(2:m,(1:n)+1)-T(2:m,(1:n)+1))./(x(2:m,(1:n)+1)-x(2:m,1:n)))));
%T_temp(2:m,1:n)=T(2:m,1:n)+delt_heat*((vel_mesh(2:m,1:n)).*((T((2:m)+1,1:n)-T((2:m)-1,1:n))./(y((2:m)+1,1:n)-y((2:m)-1,1:n)))+((DFlow(2:m,1:n)).*((((T((2:m)+1,1:n)-T(2:m,1:n))./(y((2:m)+1,1:n)-y(2:m,1:n)))-((T(2:m,1:n)-T((2:m)-1,1:n))./(y(2:m,1:n)-y((2:m)-1,1:n))))./(y(2:m,1:n)-y((2:m)-1,1:n))))-((vel_prof_y(2:m,1:n)).*((T((2:m),1:n)-T((2:m)-1,1:n))./(y((2:m),1:n)-y((2:m)-1,1:n))))-(((x(2:m,(1:n)+1)-x(2:m,1:n))./(((x(2:m,(1:n)+1)-x(2:m,1:n)).^2+(y(2:m,(1:n)+1)-y(2:m,1:n)).^2).^.5)).*(vel_prof(2:m,1:n)).*((T(2:m,(1:n)+1)-T(2:m,(1:n)))./(x(2:m,(1:n)+1)-x(2:m,1:n)))));
T_temp(2:m,2:n+1)=T(2:m,2:n+1)+delt_heat*((vel_mesh(2:m,2:n+1)).*((T((2:m)+1,2:n+1)-T((2:m)-1,2:n+1))./(y((2:m)+1,2:n+1)-y((2:m)-1,2:n+1)))+((1).*(((DFlow((2:m)+1,2:n+1).*(T((2:m)+1,2:n+1)-T(2:m,2:n+1))./(y((2:m)+1,2:n+1)-y(2:m,2:n+1)))-(DFlow(2:m,2:n+1).*(T(2:m,2:n+1)-T((2:m)-1,2:n+1))./(y(2:m,2:n+1)-y((2:m)-1,2:n+1))))./(y(2:m,2:n+1)-y((2:m)-1,2:n+1))))-((vel_prof_y(2:m,2:n+1)).*((T((2:m),2:n+1)-T((2:m)-1,2:n+1))./(y((2:m),2:n+1)-y((2:m)-1,2:n+1))))-(((x(2:m,(2:n+1))-x(2:m,(2:n+1)-1))./(((x(2:m,(2:n+1))-x(2:m,(2:n+1))-1).^2+(y(2:m,(2:n+1))-y(2:m,(2:n+1))-1).^2).^.5)).*(vel_prof(2:m,2:n+1)).*((T(2:m,(2:n+1))-T(2:m,(2:n+1)-1))./(x(2:m,(2:n+1))-x(2:m,(2:n+1)-1)))));

A1=(vel_mesh(2:m,2:n+1)).*((T((2:m)+1,2:n+1)-T((2:m)-1,2:n+1))./(y((2:m)+1,2:n+1)-y((2:m)-1,2:n+1)))+((DFlow(2:m,2:n+1)).*((((T((2:m)+1,2:n+1)-T(2:m,2:n+1))./(y((2:m)+1,2:n+1)-y(2:m,2:n+1)))-((T(2:m,2:n+1)-T((2:m)-1,2:n+1))./(y(2:m,2:n+1)-y((2:m)-1,2:n+1))))./(y(2:m,2:n+1)-y((2:m)-1,2:n+1))))-((vel_prof_y(2:m,2:n+1)).*((T((2:m),2:n+1)-T((2:m)-1,2:n+1))./(y((2:m),2:n+1)-y((2:m)-1,2:n+1))));
A2=-(((x(2:m,(2:n+1))-x(2:m,(2:n+1)-1))./(((x(2:m,(2:n+1))-x(2:m,(2:n+1))-1).^2+(y(2:m,(2:n+1))-y(2:m,(2:n+1))-1).^2).^.5)).*(vel_prof(2:m,2:n+1)).*((T(2:m,(2:n+1))-T(2:m,(2:n+1)-1))./(x(2:m,(2:n+1))-x(2:m,(2:n+1)-1))));
A3=A1+A2;
%{
D=mean(mean(DFlow));
temp_vel=mean(vel_mesh);
temp_u=mean(vel_prof);
temp=mean(T(2:m,1:n+1));
temp(1,2:n+1)=temp(1,2:n+1)+delt_heat*((temp_vel(1,2:n+1).*((T(m+1,2:n+1)-T(1,2:n+1))./(y(m+1,2:n+1)-y(1,2:n+1))))+(D*((T(m+1,2:n+1)-2*temp(1,2:n+1)+T(1,2:n+1))./((y(m+1,2:n+1)/2-y(1,2:n+1)/2).^2)))-(temp_u(1,2:n+1).*((temp(1,(2:n+1))-temp(1,(2:n+1)-1))./(x(1,(2:n+1))-x(1,(2:n+1)-1)))));
for i=2:n+1
    
   T_temp(2:m,i)=temp(1,i); 
end

%}
%T_temp(2:m,n+1)=2*T_temp(2:m,n)-T_temp(2:m,n-1);
T_temp(2:m,1)=T_temp(2:m,2);
T=T_temp;





end