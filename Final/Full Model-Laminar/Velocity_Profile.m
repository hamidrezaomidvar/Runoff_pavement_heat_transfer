function [ vel_prof,vel_prof_y ] = Velocity_Profile(t,hc,x,y,s,g,I,n,m,kin_vis)

h=zeros(m+1,n+1);
for i=1:n+1
    h(:,i)=y(m+1,i);
end
vel_prof=(g*s/kin_vis)*((h-hc).*(y-hc)-(((y-hc).*(y-hc))/2));

vel_prof_y=zeros(m+1,n+1);

for i=1:m+1
    for j=1:n+1
        if(y(i,j)<=hc)
           vel_prof(i,j)=0;
           vel_prof_y(i,j)=0;
        else
            if(x(i,j)<=(t*t*t)*s*g*I*I/(3*kin_vis) && x(i,j)~=0)
                vel_prof_y(i,j)=-(g*s*(h(i,j)-hc)*((y(i,j)-hc)^2))/(6*kin_vis*x(i,j));
            else
                vel_prof_y(i,j)=0;
            end
            
        end
    end
end


    
end


