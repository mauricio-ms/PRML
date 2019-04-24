clc, clear, close;
f = @(x) sin(2*pi*x);
N = 10;

M = 3;

x = linspace(0, 1, N)';

% Create a Guassian distribution for add some noise to data
std = .3;
variance = std^2;
u = 0;
gaussian = (1/((2*pi*variance)^.5)) * exp(-(x-u).^2/(2*variance))
% gaussian = gaussmf(x,[0.3 mean(x)]);
% Evaluate target vector adding some noise
t = f(x) + normrnd(0, 0.3, 10, 1);

figure,
plot(x, f(x)),

hold on,
plot(x, t, 'o');

A = [4 5 3.5185;
     5 3.5185 2.7778;
     3.5185 2.7778 2.3370];
b = [-.1235 -1.1639 -1.2343]'
C = [A b]
C = escalonamento(C);

w = zeros(3, 1);
w(3) = (C(3, 4) - C(3, 1:end-1) * w)/C(3, 3)
w(2) = (C(2, 4) - C(2, 1:end-1) * w)/C(2, 2)
w(1) = (C(1, 4) - C(1, 1:end-1) * w)/C(1, 1)