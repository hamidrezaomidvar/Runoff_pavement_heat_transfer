function [DFlow,DFlow_y]=diffusivity(t,visco,m,n,DWater_Molecular)
if(t<=0)
    DFlow=zeros(m+1,n+1);
    DFlow_y=zeros(m+1,n+1);
    DFlow(:,:)=4*DWater_Molecular;
else
    
    DFlow_y=zeros(m+1,n+1);
    DFlow=visco;
end
end