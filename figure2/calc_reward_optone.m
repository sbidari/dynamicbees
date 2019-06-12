
function J = calc_reward_optone(x,alpha,T)
% Calculates reward for a given value of 'parameters(x)' and 'alpha' for a
% one feeder model 
% Figure 2e

params.beta = x(1); params.gamma = x(2); params.rho = x(3);
c = 0.5*alpha;
% T = 50;
tau = .10*T;

initial = 0;                       % initial number committed to A
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);

num_period = 6;                    % # of times switch is made
end_time = num_period*T;           % end of simulation time span starting at 0

[t, y] = ode45(@(t, x) derivative(t, x, params,T, alpha,tau), ...
    [0 end_time], ...
    initial, ...
    opts);

t1 = find(t > T);
t2 = find(t > 2*T);
t3 = find(t > 3*T);
t4 = find(t > 4*T);
t5 = find(t > 5*T);

T1 = t1(1);
T2 = t2(1);
T3 = t3(1);
T4 = t4(1);
T5 = t5(1);
T6 = length(t);

J =  (trapz(t(T2:T3),y(T2:T3)*(alpha-c)) - trapz(t(T3:T4),y(T3:T4)*(c))...
    + trapz(t(T4:T5),y(T4:T5)*(alpha-c)) - trapz(t(T5:T6),y(T5:T6)*(c)))/(4*T);

end

function [dxdt] = derivative(t, x, params,T, alpha,tau)

params.alpha = f_onealt(t,T, alpha);

if t < tau
    params.lag = f_onealt(0,T, alpha);
else
    params.lag = f_onealt(t-tau,T, alpha);
end

dxdt = (params.alpha + params.beta*x)*(1- x) - x*params.gamma - params.rho*(alpha-params.lag)*x^2;

end