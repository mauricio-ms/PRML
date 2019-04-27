function W = ridgeRegression(M, x, t, lambda)
%RIDGEREGRESSION Applies the same concept that linearRegression function,
% but adding a regularization factor, this regularization factor takes the
% form (lambda/2) * w*w', but after the derivative of function, the lambda
% is added to the diagonal.
%   M is a vector of orders of coefficients. For each coefficient m in M,
% this function generate a linear system resulting from the concept of
% the partial derivatives of each coefficient.
%   x is the input vector.
%   t is the target vector.
%   lambda - Regularization factor.
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
                A(i, j) = sum(x.^powA);
                if i == j
                    A(i, j) = A(i, j) + lambda;
                end
            end
            b(i) = sum(t .* x.^powB);
        end
        W{mi} = A\b;
    end
end