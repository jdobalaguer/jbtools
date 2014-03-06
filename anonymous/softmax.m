% w = weights
% t = temperature

function i_w = softmax(w, t)
    w = w / t;
    e_w = exp(w);
    i_w = randsel(e_w);
end

function i_w = randsel(w)
    x = rand()* sum(w);
    i_w = 1;
    while x > w(i_w)
        x = x - w(i_w);
        i_w = i_w + 1;
    end
end