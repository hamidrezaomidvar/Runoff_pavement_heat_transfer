subplot(2,1,1)
load('Result/lam.mat')
plot((0:size(res3_1,2)-1)/3600,res3_1,'b','Linewidth',1.5)
hold on
load('Result/turb.mat')
plot((0:size(res3_1,2)-1)/3600,smooth(res3_1,6),'r','Linewidth',1.5)
xlabel('$t$ (h)','Interpreter','latex')
ylabel('$T_{gs}$ ({$^{\circ}$}C)','Interpreter','latex')
legend('Model of Chapter 2','New Model')
set(gca,'FontName','Times New Roman','FontSize',20)

subplot(2,1,2)
load('Result/lam.mat')
plot((0:size(res3_1,2)-1)/3600,res3_1-res4_1_3,'b','Linewidth',1.5)
hold on
load('Result/turb.mat')
plot((0:size(res3_1,2)-1)/3600,smooth(res3_1-res4_1_3,55),'r','Linewidth',1.5)
xlabel('$t$ (h)','Interpreter','latex')
ylabel('$T_{gs}-T_{ws}$ ({$^{\circ}$}C)','Interpreter','latex')
legend('Model of Chapter 2','New Model')
set(gca,'FontName','Times New Roman','FontSize',20)

figure
load('Result/lam.mat')
plot(0:200/30:200,1000*y(end,:),'b','Linewidth',1.5)
hold on
load('Result/turb.mat')
plot(0:200/30:200,1000*y(end,:),'r','Linewidth',1.5)
xlabel('$x$ (m)','Interpreter','latex')
ylabel('$h$ (mm)','Interpreter','latex')
legend('Model of Chapter 2','New Model')
set(gca,'FontName','Times New Roman','FontSize',20)


figure
subplot(2,1,1)
load('Result/lam.mat')
pcolor(x,1000*y,T);shading interp
xlabel('$x$ (m)','Interpreter','latex')
ylabel('$h$ (mm)','Interpreter','latex')
colorbar
set(gca,'FontName','Times New Roman','FontSize',20)


subplot(2,1,2)
load('Result/turb.mat')
pcolor(x,1000*y,T);shading interp
xlabel('$x$ (m)','Interpreter','latex')
ylabel('$h$ (mm)','Interpreter','latex')
set(gca,'FontName','Times New Roman','FontSize',20)
colorbar