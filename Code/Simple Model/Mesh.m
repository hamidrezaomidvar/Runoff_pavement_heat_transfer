function [y,x,dxi,det] = Mesh(m,n,l,n_manning,s,I,beta,dl)
det=1/m;
dxi=1/n;
y=zeros(m+1,n+1);
x=zeros(m+1,n+1);
%%%
for i=1:1:n+1
    alpha=exp((log((beta+1)/(beta-1)))*(1-(i-1)*dxi));
    x(:,i)=dl+l*(((beta+1)-alpha*(beta-1))/(alpha+1));
end

for i=1:1:n+1
    y_loc=(n_manning^(3/5))*(s^(-3/10))*(I^(3/5))*((x(1,i))^(3/5));
    for j=1:1:m+1
        y(j,i)=(j-1)*det*y_loc;
    end
    i
end
end


