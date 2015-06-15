
function y = sigmoid_unsigned(x)
    %% y = SIGMOID_UNSIGNED
    % sigmoid between [0,1] with temperature 1

    %% function
    y = exp(x) ./ (exp(x) + 1);
end