function [x,y,T,n1,h_top,xq,yq,hq_top,steadyState]=inter_mesh(hc,g,kin_vis,t,t_start,I,s,n,m,x,y,T,l,xq,yq,hq_top,steadyState)

if(t>0)
    l1=(t^3)*(s*g*(I^2))/(3*kin_vis);
    n1=ceil(n*(l1)/(l));
    n2=n-n1;
    if(n2==0)
        steadyState=1;
        l1=l;
    end
    h_top=I*(3*kin_vis*l1/(s*g*(I^2)))^(1/3)+hc;
    x_left_temp=0:(l1)/n1:l1;
    x_left=zeros(m+1,n1+1);
    for i=1:1:n1+1
        x_left(:,i)=x_left_temp(1,i);
    end
    %x_left(:,1:n1+1)=x_left_temp(1,1:n1+1);
    y_left=zeros(m+1,n1+1);
    for i=1:1:n1+1
        y_loc=I*(3*kin_vis*x_left(1,i)/(s*g*(I^2)))^(1/3)+hc;
        dy=y_loc/m;
        %for j=1:1:m+1
        y_left((1:m+1),i)=((1:m+1)-1)*dy;
        %end
    end
    %%%%%%%%%%%%%%
    if(steadyState==0)
        y_right=zeros(m+1,n2+1);
        for i=1:1:n2+1
            y_right(:,i)=y_left(:,n1+1);
        end
        
        x_right_temp=l1:(l-l1)/n2:l;
        x_right=zeros(m+1,n2+1);
        for i=1:1:n2+1
            x_right(:,i)=x_right_temp(1,i);
        end
    end
    %%%%%%
    %for i=1:n1+1
    x(:,1:n1+1)=x_left(:,1:n1+1);
    y(:,1:n1+1)=y_left(:,1:n1+1);
    
    %end
    if(steadyState==0)
        %for i=n1+2:n+1
        x(:,n1+2:n+1)=x_right(:,(n1+2:n+1)-(n1));
        y(:,n1+2:n+1)=y_right(:,(n1+2:n+1)-(n1));
        %end
    end
    
else
    
    for i=1:n+1
        x(:,i)=((i)-1)*(l/n);
    end
    for i=1:m+1
        y(i,:)=((i)-1)*(hc/m);
    end
    h_top=hc;
    n1=0;
    
end
%%%%%%
%{
if(t>t_start)
    if t>=0
        x=reshape(x,(n+1)*(m+1),1);
        y=reshape(y,(n+1)*(m+1),1);
        T=reshape(T,(n+1)*(m+1),1);
        xq=reshape(xq,(n+1)*(m+1),1);
        yq=reshape(yq,(n+1)*(m+1),1);
        F=scatteredInterpolant(xq,yq,T);
        T=F(x,y);
        T=vec2mat(T,m+1);
        T=T';
        x=vec2mat(x,m+1);
        x=x';
        y=vec2mat(y,m+1);
        y=y';
    else
        T=interp2(x,y,T,xq,yq,'spline');
    end
end
%}
%%%%%%%

xq=x;
yq=y;
hq_top=h_top;




end