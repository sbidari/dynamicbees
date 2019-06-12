function y = f_onealt(t,T,A)

 y = zeros(length(t),1);
 
  for i=1:length(t)
      
      if mod(t,2*T) > 0 && mod(t,2*T) <= T
          y(i) = A;
      else 
          y(i) = 0;
      end 
      
  end
  
end