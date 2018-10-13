function [T]=temp_properties(m,n,Tg_init)

Tw_init=Tg_init;
T=Tw_init*ones(m+1,n+1);
T(1,:)=Tg_init;
end