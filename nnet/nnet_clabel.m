
function clabel = nnet_clabel(nnet,label)
    %% clabel = NNET_CLABEL(nnet,label)
    % create cell for label

    %% function
    clabel = cell(1,length(nnet));
    f_loss = find(ismember({nnet.type},{'euclidean','sqeuclidean','loglhood','xentropy'}));
    clabel{f_loss} = label; %#ok<FNDSB>
end
