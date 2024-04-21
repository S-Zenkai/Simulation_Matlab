function u_i  = Find_U_I(u,ind,a)
b=a>0;
y1=ind(:,2+b)-abs(u)+eps;
y2=(y1>0);
ret=find(y2,1);
u_i=ind(ret(1),1);


