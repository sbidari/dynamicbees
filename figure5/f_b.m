function y = f_b(t,T,A)
scale = 0.5;
    y = zeros(size(t));
  for i=1:length(t)
      if mod(t,2*T) > 0 && mod(t,2*T) <= T
          y(i) = scale*A;
      else 
          y(i) = A;
      end 
  end
end