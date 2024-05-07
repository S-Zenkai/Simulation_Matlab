function [u_i,qu]  = HQ(u,du,rou,u_min,lev_max,u_)
% ii=1:lev_max;
% delta=(1-rou)/(1+rou);
% %%u_i,u_i/(1-delta),u_i*(1+delta)/(1-delta)索引表
% ind=zeros(length(1:lev_max),3);
% ind(ii,1)=(rou.^(1-ii)).*u_min;
% ind(ii,2)=ind(ii,1)./(1-delta);
% ind(ii,3)=(ind(ii,1).*(1+delta))./(1-delta);

%% 可优化编程为
delta = (1-rou) / (1+rou);
ind = ( (rou.^(1-1:lev_max)) * [u_min ; 1/(1-delta) ; (1+delta)./(1-delta)] )';
%%
%%确保输出有结果
% qu=5;
% u_i=0;
%%按du分三大类
flag=sign(du);
%% 
u_i=Find_U_I(u,ind,flag);
if isempty(u_i), u_i = 0; end
switch flag
    case -1
        %%寻找合适的u_i,du<0时u_i取abs(u)所在区间下一量化等级
%         u_i=Find_U_I(u,ind,-1);
        %%按abs（u_i)分三种情况
        if (abs(u) > (u_i/(1+delta)))&&(abs(u) <= u_i)
            qu=u_i*sign(u);
        elseif (abs(u) > u_i)&&(abs(u) <= u_i/(1-delta))
            qu=u_i*(1+delta)*sign(u);
        elseif (abs(u) >= 0)&&(abs(u) < u_min/(1+delta))
            qu=0;
        %% qu写到这里，所有if要有else，所有switch要有otherwise
        else, qu=5; u_i=0;
        %% 
        end
    case 1
        %%寻找合适的u_i,du>0时u_i取abs(u)所在区间量化等级
%         u_i=Find_U_I(u,ind,1);
        if (abs(u) > u_i)&&(abs(u) <= u_i/(1-delta))
            qu=u_i*sign(u);
        elseif (abs(u) > u_i/(1-delta))&&(abs(u) <= u_i*(1+delta)/(1-delta))
            qu=u_i*(1+delta)*sign(u);
        elseif (abs(u) >= u_min/(1+delta))&&(abs(u) <= u_min)
            qu=0;
        %%du>0&&0<abs(u)< u_min/(1+delta)未考虑
%         elseif (abs(u) >= 0)&&(abs(u) <= u_min)
%             qu=0;
        %% qu写到这里，所有if要有else，所有switch要有otherwise
        else, qu=5; u_i=0;
        %% 
        end
%     case 0
%         qu=u_;
         %% 
    otherwise
        qu=u_;
end
%% 函数最后还要加个end
end