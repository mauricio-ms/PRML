function W = min_least_squares(M, x, t)
%MIN_LEAST_SQUARES Generate arrays of coefficients w to the polynomials of
% orders based on array M that produce a minimum error to the polynomial
% w0 + w1*x + w2*x.^2 + ... + wM*x.^M
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

