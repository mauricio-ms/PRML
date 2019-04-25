function model = predict(N, W)
%PREDICT Summary of this function goes here
%   Detailed explanation goes here

    model.x = linspace(0, 1, N)';

    % Predict the target values for each model
    model.y = zeros(N, length(W));
    for wi=1:length(W)
        model.y(:, wi) = pol(model.x, W{wi});
    end
end