function [list_alpha,Reward,params] = opt_paramsone
% Compute parameter range that maximimizes the reward function
% Figure 2e

T = 1;
max_T = 200;
delta_T = 1;
list_T = T:delta_T:max_T;
step_T = round((max_T-T)/delta_T);

alpha = .5;
max_alpha = 20;
delta_alpha = .1;
list_alpha = alpha:delta_alpha:max_alpha;
step_alpha= round((max_alpha-alpha)/delta_alpha);

% Initialize parameter vectors
x = [.01;.1;1;10];
y = [.01;0.1;1;10];
z = [.01;.1;1;10];
params_list = cartprod(x,y,z);
Reward = zeros(step_T,step_alpha);
params = zeros(step_T,step_alpha,3);

for i = 1:step_T+1
    T = list_T(i);
    for j = 1:step_alpha+1
        alpha = list_alpha(j);
        reward_comp = zeros(length(params_list),1);
        for k = 1:length(params_list)
            X = params_list(k,:);
            reward_comp(k) = calc_reward_optone(X,alpha,T);
        end
        pos =  find(reward_comp == max(reward_comp));
        Reward(i,j) = reward_comp(pos);
        params(i,j,:) = params_list(pos,:);
        %         j
    end
    i
end


end
