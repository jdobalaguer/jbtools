
function y = sigmoid_unsigned(x)
    y = exp(x) ./ (exp(x) + 1);
end