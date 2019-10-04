function [Tg]=Ground_heat_sameFlux(n,mg,delt_heat,diff_asphalt,xg,Tg,delyg,dxi,xix)

T_temp=Tg;
xixp=zeros(mg+1,n+1);
for i=1:1:n+1
xixp(:,i)=xix(2,i);
end;
T_temp(2:mg,2:n)=Tg(2:mg,2:n)+delt_heat*diff_asphalt*(((Tg((2:mg)+1,2:n)-2*Tg(2:mg,2:n)+Tg((2:mg)-1,2:n))/(delyg*delyg))+(((Tg((2:mg),(2:n)+1)-2*Tg((2:mg),2:n)+Tg((2:mg),(2:n)-1))/(dxi*dxi)).*(xixp((2:mg),2:n).*xixp((2:mg),2:n))+((Tg((2:mg),(2:n)+1)-Tg((2:mg),(2:n)-1))/(dxi*2)).*(xixp((2:mg),2:n)).*((xixp((2:mg),(2:n)+1)-xixp((2:mg),(2:n)-1))/(2*dxi))));

T_temp(2:mg,1)=Tg(2:mg,1)+delt_heat*diff_asphalt*(((Tg((2:mg)+1,1)-2*Tg(2:mg,1)+Tg((2:mg)-1,1))/(delyg*delyg))+(((Tg((2:mg),(2)+1)-2*Tg((2:mg),2)+Tg((2:mg),(2)-1))/(dxi*dxi)).*(xixp((2:mg),2).*xixp((2:mg),2))+((Tg((2:mg),(2)+1)-Tg((2:mg),(2)-1))/(dxi*2)).*(xixp((2:mg),2)).*((xixp((2:mg),(2)+1)-xixp((2:mg),(2)-1))/(2*dxi))));
T_temp(2:mg,n+1)=Tg(2:mg,n+1)+delt_heat*diff_asphalt*(((Tg((2:mg)+1,n+1)-2*Tg(2:mg,n+1)+Tg((2:mg)-1,n+1))/(delyg*delyg))+(((Tg((2:mg),(n)+1)-2*Tg((2:mg),n)+Tg((2:mg),(n)-1))/(dxi*dxi)).*(xixp((2:mg),n).*xixp((2:mg),n))+((Tg((2:mg),(n)+1)-Tg((2:mg),(n)-1))/(dxi*2)).*(xixp((2:mg),n)).*((xixp((2:mg),(n)+1)-xixp((2:mg),(n)-1))/(2*dxi))));



%T_temp(1,2:n)=Tg(1,2:n)+delt_heat*diff_asphalt*(((Tg(1+1,2:n)-Tg(1,2:n))/(delyg*delyg))+(((Tg(1,(2:n)+1)-2*Tg((1),2:n)+Tg(1,(2:n)-1))/(dxi*dxi)).*(xixp((1),2:n).*xixp((1),2:n))+((Tg(1,(2:n)+1)-Tg(1,(2:n)-1))/(dxi*2)).*(xixp((1),2:n)).*((xixp(1,(2:n)+1)-xixp((1),(2:n)-1))/(2*dxi))));
T_temp(1,1:n+1)=T_temp(2,1:n+1);
%T_temp(1,1)=(T_temp(2,1)+T_temp(1,2))/2;
%T_temp(1,n+1)=(T_temp(1,n)+T_temp(2,n+1))/2;

Tg=T_temp;



end