
function y = sigmoid_signed(x)
    %% y = SIGMOID_SIGNED
    % sigmoid between [-1,+1] with temperature 1

    %% function
    y = (exp(x) - 1) ./ (exp(x) + 1);
end