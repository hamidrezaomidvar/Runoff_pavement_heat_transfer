function [y_temp,number_cell]=mesh_transient(delt_heat,DFlow,t,n_manning,s,I,y,m,n)
x_top=(t*(I^(2/5))*(n_manning^(-3/5))*(s^(3/10)))^(5/3);
h_top=(I^(3/5))*(x_top^(3/5))*(n_manning^(3/5))*(s^(-3/10));
y_temp=y;
number_cell=zeros(1,n+1);
for i=1:n+1
    for j=1:m+1
        if y(j,i)>h_top
           
            if y(j-1,i)<=h_top
                 y_temp(j,i)=h_top;
                 number_cell(1,i)=j;
            else
                y_temp(j,i)=0; 
            end
            
        end
        
    end
end
for i=1:n+1
   if number_cell(1,i)==0
       number_cell(1,i)=m+1;
   end
    
end

for i=1:n+1
 cfl=DFlow(number_cell(i),i)*delt_heat/((y_temp(number_cell(i),i)-y_temp(number_cell(i)-1,i))^2);
 if cfl>.5
   y_temp(number_cell(i),i)=0;
   y_temp(number_cell(i)-1,i)=h_top;
   number_cell(i)=number_cell(i)-1;
 end
    
end

end