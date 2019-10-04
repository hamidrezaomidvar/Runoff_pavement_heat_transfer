function [ vel_prof,vel_prof_y ] = Velocity_Profile(veloc,t,hc,x,y,s,g,I,n,m,kin_vis)
if(t>0)
    h=zeros(m+1,n+1);
    for i=1:n+1
        h(:,i)=y(m+1,i);
    end
    vel_prof=0*(g*s/kin_vis)*((h-hc).*(y-hc)-(((y-hc).*(y-hc))/2));
    
    vel_prof_y=zeros(m+1,n+1);
    
    for i=1:m+1
        for j=1:n+1
            if(y(i,j)<=hc)
                vel_prof(i,j)=0;
                vel_prof_y(i,j)=0;
            else
                vel_prof(i,j)=veloc(i,j);
                vel_prof_y(i,j)=0;
            end
        end
    end
else
    h=zeros(m+1,n+1);
    for i=1:n+1
        h(:,i)=y(m+1,i);
    end
    vel_prof=0*(g*s/kin_vis)*((h-hc).*(y-hc)-(((y-hc).*(y-hc))/2));
    vel_prof_y=zeros(m+1,n+1);
    
end


end


