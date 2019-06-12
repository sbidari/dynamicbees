function [lambda2,u] = discriminate_adaptivity_consensus_rho

syms x y real
beta = csvread('dis_beta.csv');
gamma = csvread('dis_gamma.csv');

rho = logspace(-4,log(20),100);
alpha = 2;
T = 100;
params.G = gamma(100,16);
params.B = beta(100,16);

%Initialize output vectors
lambda2 = zeros(length(rho),1);
u = zeros(length(rho),1);

for i = 1:length(rho)

    params.P = rho(i);
    
    [u1_plus,u2_plus,u1_minus,u2_minus] = bees_sim_discriminate(T,alpha,params);
    params.Aa = alpha;
    params.Ab = 0.5*alpha;
    
    d2x = (params.Aa + params.B*x)*( 1- x - y ) - x*params.G - .5*alpha*params.P*x*y;
    d2y = (params.Ab + params.B*y)*( 1- x - y ) - y*params.G - alpha*params.P*x*y;
    J2 = jacobian([d2x,d2y],[x,y]) ;
    Jac2 = double(subs(J2,{x,y},{u2_plus,u2_minus}));
    d2 = double(eig(Jac2));
    lambda2(i) = min(abs(d2));
    u(i) = u2_plus;

end
plot(lambda2,u,'Color',[0.85 0.33 0.10],'LineWidth',5)
xlabel('adaptivity $\lambda$','fontsize',25,'interpreter','latex');
ylabel('consensus $\bar{u}$','fontsize',25,'interpreter','latex');
set(gca,'fontsize',30);
end
