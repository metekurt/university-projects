%% Solution to the problem 1.1

hfile = 'exampleSignal.csv';  % Reading the WAVE FILE             
y= load('exampleSignal.csv');
N = length(y); 
np = zeros(30,1);
figure
for i = 1:30
    x = zeros(N-i+1,1);
    for r = i:-1:1
        x = x + y(r:N-(i-r));
    end
    y1 = x/i;
    np(i) = numel(findpeaks(y1));   
end 
    plot((1:30),np);
    set(gca,'FontSize',14) 
    grid
    xlabel('Number of used samples')
    ylabel('Number of peaks')

