
function nnet = nnet_example()
    %% nnet = NNET_EXAMPLE()
    % example on how to build and train a neural network
    
    %% warnings
    %#ok<*NASGU>
    
    %% function
    % neural network
    nnet = nnet_create('dot',         {.01 * randn( 6,12)}, ...
                       'sum',         {.01 * randn( 1,12)}, ...
                       'relu',        {}, ...
                       'dot',         {.01 * randn(12,12)}, ...
                       'sum',         {.01 * randn( 1,12)}, ...
                       'sqeuclidean', {},                   ...
                       'sumbatch',    {}                    );
    
    % dataset
    input = [1,0,0,0,0,0;...
             0,1,0,0,0,0;...
             0,0,1,0,0,0;...
             0,0,0,1,0,0;...
             0,0,0,0,1,0;...
             0,0,0,0,0,1];
         
    targt = [1,0,0,0,1,0,1,0,0,1,0,0;...
             1,0,0,0,0,1,1,0,0,1,0,0;...
             0,1,0,1,0,0,0,1,0,1,0,0;...
             0,1,0,1,0,0,0,0,1,1,0,0;...
             0,0,1,1,0,0,1,0,0,0,1,0;...
             0,0,1,1,0,0,1,0,0,0,0,1];

    % output predictions
    label  = {[],[],[],[],[],targt,[]};
    output = nnet_output(nnet,input,label);
    
    % calculate derivatives
    derive = nnet_derive(nnet,output,label);
    
    % training
    lrate = 0.01;
    loss = nan(3e3,1);
    for i = 1:length(loss)
        nnet = nnet_train(nnet,input,label,lrate);
        output  = nnet_output(nnet,input,label);
        loss(i) = output{end};
    end
    
    fig_figure();
    plot(loss);
    
    % it works!
    output = nnet_output(nnet,input,label);
end
