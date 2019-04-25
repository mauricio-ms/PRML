function W = mls(M, x, t)
%MLS Minimizes the error function generating a linear system from the
% partial derivatives of polynomials with the form
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