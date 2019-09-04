function y_d = delayer(y,k)% Delaying the signal for K [ms]
global Fs
         L = length(y);
         y_d = zeros(size(y));
         dt = 1/Fs;% time step
         nd = k*1e-03/dt;% number of delay samples
         y_d(nd+1:L) = y(1:L-nd);% Delayed signal 
end