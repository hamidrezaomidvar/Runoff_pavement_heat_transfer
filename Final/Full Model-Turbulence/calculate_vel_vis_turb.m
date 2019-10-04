function [vel,vis2,zv2,z0,us,hh]=calculate_vel_vis_turb(i,h,alpha,s)
vis2=0;
zv2=0;
p=i*100*3600;
vel=[];
hh=[];
g=9.8;
mu=1e-6;
k=0.4;
yt=alpha*h;
us=(g*s*yt)^.5;
%z0=mu/(9*us);
z0=0;
hp=mu*11/(us);
z=z0:(hp-z0)/200:hp;
aa=1.2;
[zp,y]=ode45(@(zp,y) (1/(mu+aa*mu*(((h*(p/(100*3600)))/mu))^0.4))*(us*us),z,0);
%plot(y,zp,'r','LineWidth',2)
up=y(end);
%hold on



yp1=mu*5/(us);
temp=find(z>=yp1);
yp1_indx=temp(1);
yp1=z(yp1_indx);

vis21=(1./(0*zp+mu/7.5+(1/1.9)*aa*mu*(((h*(p/(100*3600)))/mu))^0.4)).^(-1);
vis21=vis21(1:yp1_indx)';
visp1=vis21(end);
zv21=zp(1:yp1_indx)';
%plot(vis21,zv21)
%hold on
%plot(y(1:yp1_indx),zp(1:yp1_indx),'or')
hp1=y(yp1_indx);
%dev1=(y(yp1_indx)-y(yp1_indx-1))/(z(yp1_indx)-z(yp1_indx-1));

vel=[vel y(1:yp1_indx-1)'];
hh=[hh z(1:yp1_indx-1)];

z=hp:(h-hp)/100:h-eps;

factor=1;
if(p==0)
   factor=0; 
end
aa3=3;

eq1=[(hp)^2 (hp)^1 (1)];
eq2=[(h-eps)^2 (h-eps)^1 1];
eq3=[(yt)^2 (yt)^1 1];
%eq4=[3*(yp2)^2 2*(yp2) 1 0];
A=[eq1;eq2;eq3];
B=[0;2;1.24];
res_co=linsolve(A,B);

[zp,y]=ode45(@(zp,y) (1/(((1-factor*erf(res_co(1)*zp.*zp+res_co(2)*zp+res_co(3))))*k*us*zp*(1-zp/(h))+mu+aa*mu*(((h*(p/(100*3600)))/mu))^0.4))*(us*us*(1-zp/yt)),z,up);
%plot(y,zp,'r','LineWidth',2)
%hold on


yp2=mu*30/(us);
temp=find(z>=yp2);
yp2_indx=temp(1);
yp2=zp(yp2_indx);
%plot(y(yp2_indx:end),zp(yp2_indx:end),'or')
hp2=y(yp2_indx);
dev2=(y(yp2_indx+1)-y(yp2_indx))/(z(yp2_indx+1)-z(yp2_indx));


vis22=(1./(((1-factor*erf(res_co(1)*zp.*zp+res_co(2)*zp+res_co(3))))*k*us.*zp.*(1-zp/(h))*(1/0.8)+mu/7.5+(1/1.9)*aa*mu*(((h*(p/(100*3600)))/mu))^0.4)).^(-1);
vis22=vis22(yp2_indx:end)';
zv22=zp(yp2_indx:end)';
visp2=vis22(1);
devvis2=(vis22(1+1)-vis22(1))/(z(1+1)-z(1));
%plot(vis22,zv22)



eq1=[(yp1)^2 (yp1)^1 1];
eq2=[(yp2)^2 (yp2)^1 1];
eq3=[2*(yp2)^1 1 0];
A=[eq1;eq2;eq3];
B=[hp1;hp2;dev2];
res_co=linsolve(A,B);
zin=yp1:(yp2-yp1)/50:yp2;
yin=(res_co(1))*((zin).^2)+(res_co(2))*((zin).^1)+(res_co(3));
%plot(yin,zin,'ob')

eq1=[(yp1)^2 (yp1)^1 1];
eq2=[(yp2)^2 (yp2)^1 1];
eq3=[2*(yp2)^1 1 0];
A=[eq1;eq2;eq3];
B=[visp1;visp2;devvis2];
res_co=linsolve(A,B);
visin=(res_co(1))*((zin).^2)+(res_co(2))*((zin).^1)+(res_co(3));

%plot(visin,zin)

vis2=[vis21 visin(2:end-1) vis22];
zv2=[zv21 zin(2:end-1) zv22];
vel=[vel yin];
vel=[vel y(yp2_indx+1:end)'];
hh=[hh zin];
hh=[hh z(yp2_indx+1:end)];

end