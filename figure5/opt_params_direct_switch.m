function [list_T,list_alpha,Reward,params] = opt_params_direct_switch
% Computes parameter range that maximimizes the reward function
% Figure 5

T = 1;
max_T = 20;
delta_T = 1;
list_T = T:delta_T:max_T;
step_T = round((max_T-T)/delta_T);

alpha = .5;
max_alpha = 10;
delta_alpha = 0.1;
list_alpha = alpha:delta_alpha:max_alpha;
step_alpha= round((max_alpha-alpha)/delta_alpha);

% Initialize parameter vectors
x = [.1;1;10];
y = [.001;0.01;0.1];
z = [.1;1;10];
params_list = cartprod(x,y,x);
Reward = zeros(step_T,step_alpha);
params = zeros(step_T,step_alpha,3);

for i = 1:step_T
    T = list_T(i);
    for j = 1:step_alpha
        alpha = list_alpha(j);
        reward_comp = zeros(length(params_list),1);
        for k = 1:length(params_list)
            X = params_list(k,:);
            reward_comp(k) = calc_direct_switch(X,alpha,T);
        end
        pos =  find(reward_comp == max(reward_comp));
        Reward(i,j) = reward_comp(pos);
        params(i,j,:) = params_list(pos,:);
        %         j
    end
    i
end
xlswrite('direct_alpha.csv',list_alpha);
xlswrite('direct_T.csv',list_T);
xlswrite('direct_beta.csv',params(:,:,1));
xlswrite('direct_gamma.csv',params(:,:,2));
xlswrite('direct_rho.csv',params(:,:,3));
xlswrite('direct_reward.csv',Reward);

end
