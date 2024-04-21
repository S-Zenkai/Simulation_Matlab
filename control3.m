function [dx,x_1,x_2,x_3,u]=control3(t,x,c_1,c_2,c_3)
x_1=x(1);
x_2=x(2);
x_3=x(3);
x_1_dot=x_2+x_1^2;
z_1=x_1;
alpha_1=-c_1*z_1-x_1^2;
alpha_1_dot=-(c_1+2*x_1)*(x_2+x_1^2);
x_2_dot=x_3+x_2^2;
z_2=x_2-alpha_1;
alpha_2=-c_2*z_2-z_1-x_2^2-alpha_1_dot;
z_3=x_3-alpha_2;
%alpha_2_1_dot=-1-c_1*c_2-2*(c_1+c_2)*x_1-2*x_2-6*x_1^2;alpha对x1的求导
%alpha_2_2_dot=-c_1-2*x_2-c_1-2*x_1；alpha对x2的求导
%u=-z_2-c_3*z_3+alpha_2_1_dot*(x_2+x_1^2)+alpha_2_2_dot*(x_3+x_2^2);
u=-z_2-c_3*z_3+(-1-c_1*c_2-2*(c_1+c_2)*x_1-2*x_2-6*x_1^2)*(x_2+x_1^2)...
    +(-c_1-2*x_2-c_1-2*x_1)*(x_3+x_2^2);
x_3_dot=u;
dx=[x_1_dot;x_2_dot;x_3_dot];





