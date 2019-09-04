%% Solution to the problem 1.3
global Fs
[y, Fs] = audioread('mike.wav');% Read the signal 
K = 100;% Base Delay [ms]
y_watermarked=y+delayer(y,K);% Signal + Delayed signal 

%% Part 1
%............ N = 50, Alpha = (0-1), K = 100ms
N = 50;%  fixed
K = 100;% fixed
Alpha = (0:0.01:1);% Varying 
LA = length (Alpha);
SNR_Alpha = zeros(size(Alpha));% allocation

for sh = 1:LA
    y_filtered = FIR(y_watermarked,Alpha(sh),N,K);
    SNR_Alpha(sh) = SNR(y_filtered,y);
end
figure(1);%---------------------------- plot
plot(Alpha, SNR_Alpha,'LineWidth',2)
set(gca,'FontSize',14) 
grid
legend('N = 50, K = 100, \alpha = 0:1')
xlabel('\alpha')
ylabel('SNR [dB]')

%% Part 2
%......... Alpha = 0.2, K = 100ms, N = 1-50
Alpha = 0.2;% fixed
K = 100;% fixed
Nc = 50;% Varying 
SNR_N = zeros(Nc,1);% allocation
for sh = 1:Nc
    y_filtered = FIR(y_watermarked,Alpha,sh,K);
    SNR_N(sh) = SNR(y_filtered,y);
end
figure(2);%---------------------------- plot
grid
plot((1:Nc), SNR_N,'LineWidth',2)
set(gca,'FontSize',14) 
grid
legend('N = 1-50, K = 100, \alpha = 0.2')
xlabel('N')
ylabel('SNR [dB]')

%% Part 3 
%........ N = 50, Alpha = 0.2, K = 100, 200, 300 and 400ms
Alpha = 0.2;% Fixed
Nc = 50;% Fixed
K = (1:4)*100;% Varying
SNR_K = zeros(size(K));% allocation
for sh = 1:length(K) 
    delayed_signal = delayer(y,K(sh)) + y;
    y_filtered = FIR(delayed_signal,Alpha,Nc,K(sh));
    SNR_K(sh) = SNR(y_filtered,y); 
end
figure(3);%---------------------------- plot
plot(K, SNR_K,'LineWidth',2)
set(gca,'FontSize',14) 
grid
legend('N = 50, K = 100-400 [ms], \alpha = 0.5')
xlabel('K')
ylabel('SNR [dB]')
