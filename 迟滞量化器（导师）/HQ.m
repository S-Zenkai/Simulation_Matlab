function [u_i,qu]  = HQ(u,du,rou,u_min,lev_max,u_)
% ii=1:lev_max;
% delta=(1-rou)/(1+rou);
% %%u_i,u_i/(1-delta),u_i*(1+delta)/(1-delta)������
% ind=zeros(length(1:lev_max),3);
% ind(ii,1)=(rou.^(1-ii)).*u_min;
% ind(ii,2)=ind(ii,1)./(1-delta);
% ind(ii,3)=(ind(ii,1).*(1+delta))./(1-delta);

%% ���Ż����Ϊ
delta = (1-rou) / (1+rou);
ind = ( (rou.^(1-1:lev_max)) * [u_min ; 1/(1-delta) ; (1+delta)./(1-delta)] )';
%%
%%ȷ������н��
% qu=5;
% u_i=0;
%%��du��������
flag=sign(du);
%% 
u_i=Find_U_I(u,ind,flag);
if isempty(u_i), u_i = 0; end
switch flag
    case -1
        %%Ѱ�Һ��ʵ�u_i,du<0ʱu_iȡabs(u)����������һ�����ȼ�
%         u_i=Find_U_I(u,ind,-1);
        %%��abs��u_i)���������
        if (abs(u) > (u_i/(1+delta)))&&(abs(u) <= u_i)
            qu=u_i*sign(u);
        elseif (abs(u) > u_i)&&(abs(u) <= u_i/(1-delta))
            qu=u_i*(1+delta)*sign(u);
        elseif (abs(u) >= 0)&&(abs(u) < u_min/(1+delta))
            qu=0;
        %% quд���������ifҪ��else������switchҪ��otherwise
        else, qu=5; u_i=0;
        %% 
        end
    case 1
        %%Ѱ�Һ��ʵ�u_i,du>0ʱu_iȡabs(u)�������������ȼ�
%         u_i=Find_U_I(u,ind,1);
        if (abs(u) > u_i)&&(abs(u) <= u_i/(1-delta))
            qu=u_i*sign(u);
        elseif (abs(u) > u_i/(1-delta))&&(abs(u) <= u_i*(1+delta)/(1-delta))
            qu=u_i*(1+delta)*sign(u);
        elseif (abs(u) >= u_min/(1+delta))&&(abs(u) <= u_min)
            qu=0;
        %%du>0&&0<abs(u)< u_min/(1+delta)δ����
%         elseif (abs(u) >= 0)&&(abs(u) <= u_min)
%             qu=0;
        %% quд���������ifҪ��else������switchҪ��otherwise
        else, qu=5; u_i=0;
        %% 
        end
%     case 0
%         qu=u_;
         %% 
    otherwise
        qu=u_;
end
%% �������Ҫ�Ӹ�end
end