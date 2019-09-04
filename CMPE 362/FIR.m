function y_filtered = FIR(y,Alpha,L,K)
         y_filtered = y;% Before filtering 
         for i=1:L
             y = delayer(y,K);% Delaying the original signal 
             y_filtered = y_filtered + (-Alpha)^i * y;% Filtered signal 
         end
end
