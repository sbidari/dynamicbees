
function [] = bees_sim_lag
% Runs one deterministic simulation of the ode with one alternative
% Figure 2d

global T
T = 50;                  %Time when the switch is made
num_period = 4;          % # of times switch is made
alpha = 2;
params.beta = .2;
params.gamma = 2.3;
params.rho = 1;
tau = .1*T;
initial = 0;            % initial number committed to A
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);

end_time = num_period*T;  % end of simulation time span starting at 0

[t, y] = ode45(@(t, x) derivative(t, x, params, alpha,tau), ...
    [0 end_time], ...
    initial, ...
    opts);

% figure;
plot(t,y,'LineWidth',5,'Color',[0,0,.8]) 
% [0,.75,1] [0.2,.48,.75] [0,0,.8]
set(gca,'fontsize',20);
xlabel('time','fontsize',25,'interpreter','latex');
ylabel('Individuals commited','fontsize',25,'interpreter','latex');

end



function [dxdt] = derivative(t, x, params, alpha,tau)

global T

params.alpha = f_onealt(t,T, alpha);

if t<tau
    params.lag = f_onealt(0,T, alpha);
else
    params.lag = f_onealt(t-tau,T, alpha);
end

dxdt = (params.alpha + params.beta*x)*(1- x) - x*params.gamma - params.rho*(alpha-params.lag)*x*(1-x);

end