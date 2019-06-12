function [lambda2,u] = direct_adaptivity_consensus_gamma
% Figure 6b

syms x y real
beta = csvread('direct_beta.csv');
rho = csvread('direct_rho.csv');

gamma = linspace(.0001,20,100);
alpha = 2;
T = 100;
params.B = beta(100,16);
params.P = rho(100,16);

%Initialize output vectors
lambda2 = zeros(length(gamma),1);
u = zeros(length(gamma),1);

for i = 1:length(gamma)
    
    params.G = gamma(i);
    
    [u1_plus,u2_plus,u1_minus,u2_minus] = bees_sim_direct(T,alpha,params);
    params.Aa = alpha;
    params.Ab = 0.5*alpha;
    
    d2x = (params.Aa + params.B*x)*( 1- x - y ) - x*params.G + .5*alpha*params.P*x*y;
    d2y = (params.Ab + params.B*y)*( 1- x - y ) - y*params.G - .5*alpha*params.P*x*y;
    J2 = jacobian([d2x,d2y],[x,y]) ;
    Jac2 = double(subs(J2,{x,y},{u2_plus,u2_minus}));
    d2 = double(eig(Jac2));
    lambda2(i) = min(abs(d2));
    u(i) = u2_plus;

end
% figure;
plot(lambda2,u,'Color',[0 0.45 0.74],'LineWidth',5)
set(gca,'fontsize',20);
xlabel('adaptivity $\lambda$','fontsize',25,'interpreter','latex');
ylabel('consensus $\bar{u}$','fontsize',25,'interpreter','latex');

end
