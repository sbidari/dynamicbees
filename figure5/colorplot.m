% Creates colorplots of the optimal parameters 
% Figure 5

B=csvread('direct_beta.csv');
G=csvread('direct_gamma.csv');
P=csvread('direct_rho.csv');
list_T=csvread('direct_T.csv');
list_alpha = csvread('direct_alpha.csv');

figure;
colorDepth = 10000;
colormap(pink(colorDepth));
hold on;
pcolor(list_alpha(1:end-1),list_T(1:end-1),B); shading flat; colorbar
[B1,hfigc] = contour(list_alpha(1:end-1),list_T(1:end-1),B,[0:0:0]);
set(hfigc,'LineWidth',1.0,'Color', [0 0 0]);
xlabel('$\alpha$','fontsize',25,'interpreter','latex');
ylabel('T','fontsize',25,'interpreter','latex');
% title('$\beta$','fontsize',25,'interpreter','latex');
set(gca,'fontsize',30);

figure;
colorDepth = 10000;
colormap(pink(colorDepth));
hold on;
pcolor(list_alpha(1:end-1),list_T(1:end-1),G); shading flat; colorbar
[G1,hfigc] = contour(list_alpha(1:end-1),list_T(1:end-1),G,[0:0:0]);
set(hfigc,'LineWidth',1.0,'Color', [0 0 0]);
xlabel('$\alpha$','fontsize',25,'interpreter','latex');
ylabel('T','fontsize',25,'interpreter','latex');
% title('$\gamma$','fontsize',25,'interpreter','latex');
set(gca,'fontsize',30);

% Main Plot
figure;
colorDepth = 10000;
colormap(pink(colorDepth));
hold on;
pcolor(list_alpha(1:end-1),list_T(1:end-1),P); shading flat; %colorbar
[P1,hfigc] = contour(list_alpha(1:end-1),list_T(1:end-1),P,[0:0:0]);
set(hfigc,'LineWidth',1.0,'Color', [0 0 0],'linestyle', 'none');
box 'on';
xlabel('$\alpha$','fontsize',25,'interpreter','latex');
ylabel('T','fontsize',25,'interpreter','latex');
% title('$\rho$','fontsize',25,'interpreter','latex');
set(gca,'fontsize',30);
% Add inset
ax1 = axes('Position',[.3 .3 .4 .2]);
box (ax1, 'on');
pcolor(list_alpha(1:6),list_T(1:5),P(1:5,1:6));
shading flat;
set(gca,'fontsize',30);

