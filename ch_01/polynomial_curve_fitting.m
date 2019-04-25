close all, clear, clc;

% Define the function
f = @(x) sin(2*pi*x);

% Plot the function
x_plot = 0:.01:1;
figure,
plot(x_plot, f(x_plot), 'g'),
xlabel("x"), ylabel("t"),
axis square;

% Create some points
N = 10;
x = linspace(0, 1, N)';
% Create a random Guassian distribution for add some noise to data
std = .3;
gaussian = normrnd(0, std, N, 1);
% Evaluate target vector adding some noise
t = f(x) + gaussian;

% Plot the target values above the function
hold on,
plot(x, t, 'o');

% Generate the model resolving the linear system generated from the
% partial derivatives of the polynomial with order M
M = 0:9;
W = cell(length(M), 1);
y = zeros(N, length(M));
for mi=1:length(M)
    m = M(mi);
    coefficients = m+1;
    A = zeros(coefficients, coefficients);
    b = zeros(coefficients, 1);

    for i=1:coefficients
        powB = i-1;
        for j=1:coefficients
            powA = powB + (j-1);
            A(i, j)= sum(x.^powA);
        end
        b(i) = sum(t .* x.^powB);
    end
    W{mi} = A\b;
end

% Creating the data
training = predict(10, W);
test = predict(100, W);

% Calculating the RMS errors
gaussian = normrnd(0, std, 100, 1);
t_test = f(test.x) + gaussian; % Generate the target vector for test data
training.rms = zeros(length(W), 1);
test.rms = zeros(length(W), 1);
for wi=1:length(W)
    training.rms(wi) = rmse(training.y(:, wi), t);
    test.rms(wi) = rmse(test.y(:, wi), t_test);
end

% Plot the results of the test data for models generated with orders 
% 0, 1, 3 and 9
idx_w = [0 1 3 9] + 1;
figure,
for wi=1:length(idx_w)
    subplot(2, 2, wi),
    plot(x_plot, f(x_plot), 'g'),
    xlabel("x"), ylabel("t"),
    axis square;
    
    hold on,
    plot(x, t, 'o');
    
    hold on,
    plot(test.x, test.y(:, idx_w(wi)), 'r');
    
    title(['Error function = ' num2str(test.rms(wi))]);
end

% Plot a comparison of errors between test and training data to shor the
% over-fitting problem
figure,
plot(M, training.rms, 'bO-'),
hold on,
plot(M, test.rms, 'rO-'),
axis([0 9 0 1]),
xlabel('M'), ylabel('Erms'),
legend({'Training', 'Test'});