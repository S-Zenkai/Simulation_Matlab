%clear all ;
close all ;
clc
x0=[0.5;0.5;0.5];
Tf=10;
c_1=1;
c_2=3;
c_3=3;
[t,x]=ode45(@model3,[0,Tf],x0,[],c_1,c_2,c_3);
%预分配内存，消除下面的警告
L=length(t);
dx = zeros(L, 3);
x_1 = zeros(L, 1);
x_2 = zeros(L, 1);
x_3 = zeros(L, 1);
u = zeros(L, 1);
for i=1:L
   [dx,x_1(i),x_2(i),x_3(i),u(i)]=control3(t(i),x(i,:),c_1,c_2,c_3);
end
figure
plot(t,x_1,t,x_2,t,x_3);