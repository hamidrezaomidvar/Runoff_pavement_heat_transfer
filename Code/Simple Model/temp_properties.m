function [T]=temp_properties(Train,m,n,Tg_init,hc,DWater_Molecular,I)

%Tw_init=Train;
Tw_init=Tg_init;
T=Tw_init*ones(m+1,n+1);
T(1,:)=Tg_init;
%{
for i=2:m+1
    
   T(i,:)=((Tg_init-Train))*erfc(((i-1)*(hc/m))/((4*DWater_Molecular*(hc/I))^.5))+Train; 
end
%}
end