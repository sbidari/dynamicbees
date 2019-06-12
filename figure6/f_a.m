function y = f_a(t,T,alpha)
scale = 0.5;
 y = zeros(length(t),1);
  for i=1:length(t)
      if mod(t,2*T) > 0 && mod(t,2*T) <= T
          y(i) = alpha;
      else 
          y(i) = scale*alpha;
      end 
  end 
end