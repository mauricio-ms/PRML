function y = pol(x, w)
%POL Calculate the polynomial w0 + w1*x + w2*x.^2 + ... + wM*x.^M
    y = zeros(size(x));
    x_power = (0:length(w)-1)';
    for xi=1:length(x)
        y(xi) = sum(w .* x(xi).^x_power);
    end
end