clc, clear, close;
f = @(x) sin(2*pi*x);
N = 10;

M = 3;

x = linspace(0, 1, N)';

% Create a Guassian distribution for add some noise to data
std = .3;
variance = std^2;
gaussian = 1/(2*pi*variance)^.5 * exp(-(1/2*variance)*(x-mean(x)).^2);
% Evaluate target vector adding some noise
t = f(x) .* normrnd(0, 0.3, 10, 1);

x_power = (0:M-1)';
% Derivada de  @(w) w(1) + w(2)*x + w(3)*x.^2 + w(4)*x.^3;
p = @(w) w(1) + w(2)*x + w(3)*x.^2 + w(4)*x.^3;
pd = @(w) 1 + w(2) + 2*w(3)*x + 3*w(4)*x.^2;

w = [0.31 7.99 -25.43 17.37];
figure,
% plot(x, p([0.31 7.99 -25.43 17.37]))
plot(x, p(w))

% % syms w
% w = -10:10;
% diff(p(w));
% % 
% % w = 1:10;
% % 
% figure,
% plot(1:9, diff(p(w))),
% grid

syms w0
syms w1
e = @(w0, w1) .5 * sum(((w0 + w1*x) -t).^2)
ed = matlabFunction(diff(e(w0, w1)))

s = -10:.1:10;
figure,
plot(s, ed(s)),
grid;

p = @(w) .5 * ((w-0)^2 + (w-0.8490)^2 + (w-1.3051)^2 + (w-1.1502)^2 + (w-0.4548)^2 + (w-(-0.4548))^2 + (w-(-1.1502))^2 + (w-(-1.3051))^2 + (w-(0.8490))^2 + (w-(-0.0000))^2 );

count = 1;
for i=-10:.1:10
   Y(count) = p(i);
   count = count+1;
end

figure,
plot(s, Y),
grid;

p = @(w) .5 * ((w-0).^2 + (w-0.8490).^2 + (w-1.3051).^2 + (w-1.1502).^2 + (w-0.4548).^2 + (w-(-0.4548)).^2 + (w-(-1.1502)).^2 + (w-(-1.3051)).^2 + (w-(0.8490)).^2 + (w-(-0.0000)).^2);
figure,
plot(s, p(s)),
grid;

s = -10:.1:10;
syms w
pd = matlabFunction(diff(p(w)))

x1 = 0.20;
tol = .5e-12;
kmax = 10000;
[x, ERel, k] = newtonraphson(pd, x1, tol, kmax)

% p2 = @(w0, w1) .5 * (((w0 + w1 * 0) -0).^2 + ((w0 + w1 * 0.1111)-0.8490).^2 + ((w0 + w1 * 0.2222)-1.3051).^2 + ...
%     ((w0 + w1 * 0.3333)-1.1502).^2 + ((w0 + w1 * 0.4444)-0.4548).^2 + ((w0 + w1 * 0.5556) ...
%     -(-0.4548)).^2 + ((w0 + w1 * 0.6667)-(-1.1502)).^2 + ((w0 + w1 * 0.7778)-(-1.3051)).^2 + ...
%     ((w0 + w1 * 0.8889)-(0.8490)).^2 + ((w0 + w1 * 1.0000)-(-0.0000)).^2);
% figure,
% plot(s, p2(s)),
% grid;
% 
% syms w0
% 
% x1 = 0.20;
% tol = .5e-12;
% kmax = 10000;
% [x, ERel, k] = newtonraphson(pd, x1, tol, kmax)