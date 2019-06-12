
function [J] = calc_indiscriminate(x,alpha,T)

% Indiscriminate model

params.B = x(1); params.G = x(2); params.P = x(3);
c = 0.5*alpha;
tau = .1*T;

num_period = 6;
initial.A = 0;
initial.B = 0;
end_time = num_period*T;  % end of simulation time span starting at 0
opts = odeset('RelTol',1e-10,'AbsTol',1e-12);

[t, y] = ode15s(@(t, x) derivative(t, x, params, alpha,T,tau), ...
    [0 end_time], ...
    [initial.A; initial.B], ...
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

J = (trapz(t(T2:T3),y(T2:T3,1)*(alpha-c)) + trapz(t(T3:T4),y(T3:T4,1)*(0.5*alpha-c))...
    + trapz(t(T4:T5),y(T4:T5,1)*(alpha-c)) + trapz(t(T5:T6),y(T5:T6,1)*(0.5*alpha-c))...
    + trapz(t(T2:T3),y(T2:T3,2)*(0.5*alpha-c)) + trapz(t(T3:T4),y(T3:T4,2)*(alpha-c))...
    + trapz(t(T4:T5),y(T4:T5,2)*(0.5*alpha-c)) + trapz(t(T5:T6),y(T5:T6,2)*(alpha-c)))/(4*T);

end

function [dxdt] = derivative(t, x, params, alpha,T,tau)

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
