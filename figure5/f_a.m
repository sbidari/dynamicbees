function y = f_a(t,T,A)
scale = 0.5;
 y = zeros(length(t),1);
  for i=1:length(t)
      if mod(t,2*T) > 0 && mod(t,2*T) <= T
          y(i) = A;
      else 
          y(i) = scale*A;
      end 
  end 
end