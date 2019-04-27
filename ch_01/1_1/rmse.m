function [rms, error] = rmse(y, t)
%RMSE Return the error that measures the misfit between the polynomial
% function that it is a nonnegative quantity that would be zero if, and 
% only if, the function y(x, w) were to pass exactly through each data 
% point.
    error = .5 * sum((y - t).^2);
    rms = sqrt(2*error / length(y));
end

