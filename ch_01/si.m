clc, clear, close;
f = @(x) sin(2*pi*x);
N = 10;

x = linspace(0, 1, N)';
t = f(x) + normrnd(0.5, 0.3, 10, 1);

% M = 1
A = [N sum(x);
     sum(x) sum(x)^2];
b = [sum(t) sum(t)*sum(x)]';
C = [A b];
C = escalonamento(C);

linhas = size(C, 1);
colunas = size(C, 2);
w = zeros(2, 1);
w(2) = C(linhas, colunas)/C(linhas, linhas);
w(1) = (C(1, linhas) - C(1, 1:end-1) * w)/C(1, 1);
% w
% M = 2
A = [N         sum(x)   sum(x.^2) sum(x.^3);
     sum(x)    sum(x.^2) sum(x.^3) sum(x.^4);
     sum(x.^2) sum(x.^3) sum(x.^4) sum(x.^5);
     sum(x.^3) sum(x.^4) sum(x.^5) sum(x.^6)];
b = [sum(t) sum(t.*x) sum(t.*(x.^2)) sum(t.*(x.^3))]';
C = [A b];
C = escalonamento(C);

linhas = size(C, 1);
colunas = size(C, 2);
w = zeros(linhas, 1);
w(4) = C(linhas, colunas)/C(linhas, linhas);
w(3) = (C(3, colunas) - C(3, 1:end-1) * w)/C(3, 3);
w(2) = (C(2, colunas) - C(2, 1:end-1) * w)/C(2, 2);
w(1) = (C(1, colunas) - C(1, 1:end-1) * w)/C(1, 1);
w