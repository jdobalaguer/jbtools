
function output = nnet_output(nnet,input,label)
    %% output = NNET_OUTPUT(nnet,input[,label])
    % get predictions from a neural network
    
    %% function
    
    % default
    func_default('label',cell(size(nnet)));
    
    % variables
    n    = length(nnet);
    h    = cell(1,n+1);
    h{1} = input;
    
    % make predictions
    for i = 1:n
        h{i+1} = nnet(i).output(nnet(i), h{i}, label{i});
    end
    
    % return
    output = h;
end
