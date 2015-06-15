
function i = softmax(w,t)
    %% i_w = SOFTMAX(w,t)
    % random selection using a softmax rule
    % w = weights
    % t = temperature
    % i = index chosen
    
    %% function
    w = w / t;
    e = exp(w);
    i = randsel(e);
end

%% auxiliar
function i_w = randsel(w)
    x = rand()* sum(w);
    i_w = 1;
    while x > w(i_w)
        x = x - w(i_w);
        i_w = i_w + 1;
    end
end