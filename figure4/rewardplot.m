% Plot reward rate against $T$ and $\alpha$
% Figure 4

R_dis = csvread('dis_reward.csv');
R_indis = csvread('indis_reward.csv');
R_self = csvread('self_reward.csv');
R_direct = csvread('direct_reward.csv');
list_alpha = csvread('dis_alpha.csv');
list_T = csvread('dis_T.csv');

%% Fixed T, vary \alpha 

figure;
plot(list_alpha(1:end-1),R_direct(100,:),'Linewidth',5)
hold on;
plot(list_alpha(1:end-1),R_dis(100,:),'Linewidth',5)
plot(list_alpha(1:end),R_indis(100,:),'Linewidth',5)
plot(list_alpha(1:end-1),R_self(100,:),'Linewidth',5)
hold off;

figure;
loglog(list_alpha(1:end-1),R_direct(5,:),'Linewidth',5)
hold on;
loglog(list_alpha(1:end-1),R_dis(5,:),'Linewidth',5)
loglog(list_alpha(1:end),R_indis(5,:),'Linewidth',5)
loglog(list_alpha(1:end-1),R_self(5,:),'Linewidth',5)
hold off;

set(gca,'fontsize',20); box off;
xlabel('Food site quality $\bar{\alpha}$','fontsize',25,'interpreter','latex');
ylabel('Reward rate','fontsize',25,'interpreter','latex');
legend('direct switch','discriminate','indiscriminate','self inhibition');

%% Fixed \alpha, vary across T

figure;
loglog(list_T(1:end-1),R_direct(:,46),'Linewidth',5)
hold on;
loglog(list_T(1:end-1),R_dis(:,46),'Linewidth',5)
loglog(list_T(1:end),R_indis(:,46),'Linewidth',5)
loglog(list_T(1:end-1),R_self(:,46),'Linewidth',5)

loglog(list_T(1:end-1),R_direct(:,16),'Linewidth',5,'Color',[0.00,0.45,0.74])
loglog(list_T(1:end-1),R_dis(:,16),'Linewidth',5,'Color',[0.85,0.33,0.10])
loglog(list_T(1:end),R_indis(:,16),'Linewidth',5,'Color',[0.93,0.69,0.13])
loglog(list_T(1:end-1),R_self(:,16),'Linewidth',5,'Color',[0.49,0.18,0.56])

loglog(list_T(1:end-1),R_direct(:,6),'Linewidth',5,'Color',[0.00,0.45,0.74])
loglog(list_T(1:end-1),R_dis(:,6),'Linewidth',5,'Color',[0.85,0.33,0.10])
loglog(list_T(1:end),R_indis(:,6),'Linewidth',5,'Color',[0.93,0.69,0.13])
loglog(list_T(1:end-1),R_self(:,6),'Linewidth',5,'Color',[0.49,0.18,0.56])
hold off;

set(gca,'fontsize',20); box off;
xlabel('Period of switch $T$','fontsize',25,'interpreter','latex');
ylabel('Foraging yield','fontsize',25,'interpreter','latex');
legend('direct switch','discriminate','indiscriminate','self inhibition');
