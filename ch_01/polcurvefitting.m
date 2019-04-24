function model = polcurvefitting(f, N, M)
%POLCURVEFITTING Summary of this function goes here
%   Detailed explanation goes here
    x = linspace(0, 1, N)';

    % Create a Guassian distribution for add some noise to data
    std = .3;
    variance = std^2;
    gaussian = 1/(2*pi*variance)^.5 * exp(-(1/2*variance)*(x-mean(x)).^2);
    % Evaluate target vector adding some noise
    t = f(x) .* gaussian;

    % Perform the equation to discover the coefficients of W of different
    % magnitudes M
    W = cell(length(M), 1);
    y = zeros(N, length(M));
    error = zeros(1, length(M));
    errorRms = zeros(1, length(M));
    for mi=1:length(M)
        FI = zeros(N, M(mi)+1);
        for xi=0:M(mi)
            FI(:, xi+1) = x.^xi;
        end
        W{mi} = inv(FI' * FI) * FI' * t;
        
        y(:, mi) = pol(x, W{mi});
        
        % Calculating the error that measures the misfit between the polynomial
        % function that it is a nonnegative quantity that would be zero if, and 
        % only if, the function y(x, w) were to pass exactly through each training 
        % data point.
        error(mi) = .5 * sum((y(:, mi) - t).^2);
        errorRms(mi) = sqrt(2 * .5 * sum((y(:, mi) - t).^2) / N);
    end
    
    model.M= M;
    model.x = x;
    model.t = t;
    model.W = W;
    model.y = y;
    model.error = error;
    model.errorRms = errorRms;
end