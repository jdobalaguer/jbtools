
function nnet = nnet_update(nnet,derive,lrate)
    %% nnet = NNET_UPDATE(nnet,derive,lrate)
    % update parameters based on gradient-descent
    
    %% function
    
    for i = 1:length(nnet)
        for j = 1:length(nnet(i).parameters)
            nnet(i).parameters{j} = nnet(i).parameters{j} - (lrate .* derive{i}{j+1});
        end
    end
end
