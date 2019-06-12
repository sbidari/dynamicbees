
function [solx, soly] = eval_initial(u1_plus,u1_minus,lambda1,T)

syms x y 
eqns =  [u1_plus + exp(-lambda1*T)*(x-u1_plus) == y, ...
    u1_minus + exp(-lambda1*T)*(y-u1_minus) == x] ;
vars = [x y];
[solx, soly] = vpasolve(eqns,vars);

end 