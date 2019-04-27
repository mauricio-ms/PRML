function model = predict(N, W)
%PREDICT Predict the y values for the 0:1 uniform spaced array of size M.
% Use the pol function to obtain the target values passing an array of 2
% coefficients.
    model.x = linspace(0, 1, N)';

    % Predict the target values for each model
    model.y = zeros(N, length(W));
    for wi=1:length(W)
        model.y(:, wi) = pol(model.x, W{wi});
    end
end