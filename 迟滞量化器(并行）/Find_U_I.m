%%a1=u_i/(1-delta),a2=u_i,a3=u_i/(1-delta),a4=u_i*(1+delta)/(1-delta)
%%du>0,abs(u)<a4,ȡi�����ȼ�
%%du<0,a1<abs(u)<a3,ȡi�����ȼ�;a3<abs(u)<a4,ȡi+1�����ȼ�
function u_i  = Find_U_I(u,ind,a)
b=a>0;
y1=ind(:,2+b)-abs(u)+eps;
y2=(y1>0);
ret=find(y2,1);
if isempty(ret)
    u_i=-1;
else
    u_i=ind(ret(1),1);
end


