function [DFlow,DFlow_y]=diffusivity(m,n,DWater_Molecular)
DFlow=zeros(m+1,n+1);
DFlow_y=zeros(m+1,n+1);
DFlow(:,:)=DWater_Molecular;
end