function [ety,xix,etx,det,dxi]=Transfer_mesh(t,hc,m,s,I,x,y,n1,h_top,n,l,g,kin_vis)
if(t>0)
    hx(:,1:n1+1)=hc+(I)*((3*kin_vis/(s*g*(I^2))).^(1/3))*((x(:,1:n1+1)).^(1/3));
    hx(:,n1+2:n+1)=h_top+hc;
    hxp(:,1:n1+1)=(1/3)*(I)*((3*kin_vis/(s*g*(I^2))).^(1/3))*((x(:,1:n1+1)).^(-2/3));
    hxp(:,n1+2:n+1)=0;
    ety=1./hx;
    xix=ones(m+1,n+1);
    xix=xix./l;
    etx(:,:)=-y(:,:).*hxp(:,:)./(hx(:,:).^2);
    det=1/m;
    dxi=1/n;
    
else
    hx(1:m+1,1:n1+1)=hc;
    hx(1:m+1,n1+2:n+1)=hc;
    hxp(1:m+1,1:n1+1)=0;
    hxp(1:m+1,n1+2:n+1)=0;
    ety=1./hx;
    xix=ones(m+1,n+1);
    xix=xix./l;
    etx(1:m+1,1:n+1)=0;
    det=1/m;
    dxi=1/n;
    
end
end