
function nnet = nnet_train(nnet,input,label,lrate)
    %% nnet = NNET_TRAIN(nnet,input,label,lrate)
    % train a neural network with back-propagation gradient-descent.
    
    %% function
    
    output = nnet_output(nnet,input,label);
    derive = nnet_derive(nnet,output,label);
    nnet   = nnet_update(nnet,derive,lrate);
    
end
