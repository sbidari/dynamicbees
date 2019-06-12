function y = f_b(t,T,alpha)
scale = 0.5;
    y = zeros(size(t));
  for i=1:length(t)
      if mod(t,2*T) > 0 && mod(t,2*T) <= T
          y(i) = scale*alpha;
      else 
          y(i) = alpha;
      end 
  end
end