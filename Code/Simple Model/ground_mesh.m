function [xg,xqg,yg,yqg,Tg]=ground_mesh(xg,xqg,yg,yqg,Tg,x,n,mg,t_start,t,delyg)




for i=1:mg+1
    yg(i,:)=(mg+1-i)*delyg;
end
for j=1:n+1
    xg(:,j)=x(1,j);
end


% if(t>0)
%     xg=reshape(xg,(n+1)*(mg+1),1);
%     yg=reshape(yg,(n+1)*(mg+1),1);
%     Tg=reshape(Tg,(n+1)*(mg+1),1);
%     
%     
%     if(t>t_start)
%         xqg=reshape(xqg,(n+1)*(mg+1),1);
%         yqg=reshape(yqg,(n+1)*(mg+1),1);
%         F=scatteredInterpolant(xqg,yqg,Tg);
%         Tg=F(xg,yg);
%         Tg=vec2mat(Tg,mg+1);
%         Tg=Tg';
%         xg=vec2mat(xg,mg+1);
%         xg=xg';
%         yg=vec2mat(yg,mg+1);
%         yg=yg';
%     end
%     
%     if(t==t_start)
%         Tg=vec2mat(Tg,mg+1);
%         Tg=Tg';
%         xg=vec2mat(xg,mg+1);
%         xg=xg';
%         yg=vec2mat(yg,mg+1);
%         yg=yg';
%     end
%     
% end

xqg=xg;
yqg=yg;
end