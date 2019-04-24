function [x, ERel, k] = newtonraphson(f, x1, tol, kmax)
%NEWTONRAPHSON Calcula uma aproxima��o para o zero da f em [a, b], a partir
% de um inicializador x1. x1 deve ser escolhido no intervalo [a, b], ou
% seja, deve estar suficientemente pr�ximo de z.
    ERel = Inf;
    k = 1;
    xAnt = x1;
    
    syms x
    df = matlabFunction(diff(f(x)));
    
    while ERel >= tol && k<kmax
       try
            x = xAnt - f(xAnt)/df(xAnt);
       catch
            x = xAnt - f(xAnt)/df();
       end
       k = k + 1;
       ERel = abs((x-xAnt)/x);
       xAnt = x;
    end
end