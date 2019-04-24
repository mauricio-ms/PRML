function y = pol(x, w)
%POL Execute the polynomial function for all itens in X for each
%   W coefficients
    y = zeros(size(x));
    x_power = (0:length(w)-1)';
    for xi=1:length(x)
        y(xi) = sum(w .* x(xi).^x_power);
    end
end

