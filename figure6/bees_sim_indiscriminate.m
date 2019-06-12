
function [u1_plus,u2_plus,u1_minus,u2_minus] = bees_sim_indiscriminate(T,alpha,params)

num_period = 6;          % # of times switch is made
tau = .1*T;

initial.A = 0;            % initial number committed to A
initial.B = 0;            % initial number committed to B

end_time = num_period*T;  % end of simulation time span starting at 0
opts = odeset('RelTol',1e-12,'AbsTol',1e-12);

[t, y] = ode15s(@(t, x) derivative(T,t, x, params, alpha,tau), ...
    [0 end_time], ...
    [initial.A; initial.B], ...
    opts);

t1 = y(t >= 2*T+tau);
t2 = y(t >= 3*T);
t3 =y(t >= T + tau);
t4 =y(t >= 2*T);

u1_plus = t1(1);
u2_plus = t2(1);
u1_minus = t3(1);
u2_minus = t4(1);

% figure;
% plot(t,y)
end

function [dxdt] = derivative(T,t, x, params, alpha,tau)

params.Aa = f_a(t,T, alpha);
params.Ab = f_b(t,T, alpha);

if t<tau
    params.lagA = f_a(0,T, alpha);
    params.lagB = f_b(0,T, alpha);
else
    params.lagA = f_a(t-tau,T, alpha);
    params.lagB = f_b(t-tau,T, alpha);
end

dxdt = zeros(2,1);

dxdt(1) = (params.Aa + params.B*x(1))*( 1- x(1) - x(2) ) - x(1)*params.G - 0.5*(params.P*params.lagA*x(1)^2+params.P*params.lagB*x(1)*x(2));
dxdt(2) = (params.Ab + params.B*x(2))*( 1- x(1) - x(2) ) - x(2)*params.G - 0.5*(params.P*params.lagB*x(2)^2+params.P*params.lagA*x(1)*x(2));
end



