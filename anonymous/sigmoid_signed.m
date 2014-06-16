
function y = sigmoid_signed(x)
    y = (exp(x) - 1) ./ (exp(x) + 1);
end