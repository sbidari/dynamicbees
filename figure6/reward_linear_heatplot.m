function [] = reward_linear_heatplot
% approximate reward rate using linear approximation for different values
% of $\lambda$ and $\bar{u}$
% Figure 6a

u_list = 0:.01:.9;
lambda_list = 0:0.01:1;
Reward = zeros(length(u_list),length(lambda_list));
T = 100;
alpha = 2;
c = 0.5*alpha;
u1_minus = 0.1;

for i=1:length(u_list)
    u1_plus = u_list(i);
    for j = 1:length(lambda_list)
        lambda1 = lambda_list(j);
        [u,v] = eval_initial(u1_plus,u1_minus,lambda1,T);
        Reward(i,j) = (1/T)*( u1_plus*T*(alpha-c) + u1_minus*T*(.5*alpha-c) +...
        ((1-exp(-lambda1*T))/lambda1)*((u-u1_plus)*(alpha-c)+(v-u1_minus)*(.5*alpha-c)));
    end
    i
end

figure;
colorDepth = 10000;
colormap(hot(colorDepth));
hold on;
pcolor(lambda_list,u_list,Reward); shading flat
colorbar;
[R,hfigc] = contour(lambda_list,u_list,Reward,[0:0:0]);
set(hfigc,'LineWidth',1.0,'Color', [0 0 0]);
set(gca,'fontsize',20);

xlabel ('\lambda','FontSize',25);
ylabel ('u','FontSize',25);

end