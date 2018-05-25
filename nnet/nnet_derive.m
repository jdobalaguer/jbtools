
function derive = nnet_derive(nnet,output,label)
    %% derive = NNET_DERIVE(nnet,output,label)
    % train a neural network with back-propagation gradient-descent.
    
    %% function
    
    % default
%     func_default('label',cell(size(nnet)));
    
    % variables
    n      = length(nnet);
    d      = cell(1,n+1);
    d{n+1} = {ones(size(output{n+1}))};
    
    % make predictions
    for i = n:-1:1
        d{i} = nnet(i).derive(nnet(i), output{i}, output{i+1}, d{i+1}{1}, label{i});
    end
    
    % return
    derive = d;
end
