function [data,time,pr]=loadData_before_rain()
data1=importdata('broadmead_2016/CR5000_flux_2016_07.dat');
data1=data1.data;
day=30;
start=(day-1)*24*12+1;
finish=start+287;
day_data=data1(start:finish,:);
target=day_data(11:227,:);
final_data_5=target(:,[82,81,84,83,34,35,33,38,32,88,89]);

nf1=size(final_data_5,1);
nf2=size(final_data_5,2);
temp=zeros(nf1*300,nf2);
for i=0:nf1-1
    for j=i*300+1:i*300+1+299
        temp(j,:)=final_data_5(i+1,:);
    end
end
temp(:,10)=100*temp(:,5)./(temp(:,5)+temp(:,6));
temp(:,8)=temp(1,8);
temp(:,9)=(10)*temp(:,9);
data={temp,temp};
fileID = fopen('properties_case_study_before.txt');
pr=textscan(fileID,'%s %s %s %f %f %f %s %s %s %s %s %f %f %f %f %f');
z1=cell2mat(pr(1,14));
z2=cell2mat(pr(1,15));
time=z1:z2;


end