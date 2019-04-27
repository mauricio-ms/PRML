function W = linearRegression(M, x, t)
%LINEARREGRESSION Minimizes the least squares error function.
%   M is a vector of orders of coefficients. For each coefficient m in M,
% this function generate a linear system resulting from the concept of
% the partial derivatives of each coefficient.
%   x is the input vector.
%   t is the target vector.
    W = cell(length(M), 1);
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
end