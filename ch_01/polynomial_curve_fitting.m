%% 1.1. Example: Polynomial Curve Fitting
close, clear, clc;

f = @(x) sin(2*pi*x);
N = 10;
M = [0 1 3 9];
training = polcurvefitting(f, N, M);

% Plot the results
figure,
for wi=1:length(training.W)
    subplot(2, 2, wi),
    plot(training.x, f(training.x), 'g'),
    xlabel("x"), ylabel("t"),
    axis square;
    
    hold on,
    plot(training.x, training.t, 'o');
    
    hold on,
    plot(training.x, training.y(:, wi), 'r');
    
    title(['Error function = ' num2str(training.error(wi))]);     
end

% Creating the test data set
N = 100;
test = polcurvefitting(f, N, M);

figure,
plot(training.M, training.errorRms, 'bO-'),
hold on,
plot(test.M, test.errorRms, 'rO-');