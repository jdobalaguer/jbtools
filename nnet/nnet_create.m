
function nnet = nnet_create(varargin)
    %% nnet = NNET_CREATE(var1,val1,[var2,val2][,..])
    % create a neural network
    
    %% warnings (for now)
    %#ok<*INUSD>
    %#ok<*NASGU>
    %#ok<*INUSL>
    
    %% function
    
    % initialise variables
    var  = varargin(1:2:nargin);
    val  = varargin(2:2:nargin);
    n    = length(var);
    nnet = struct('type',cell(1,n),'parameters',cell(1,n),'output',cell(1,n),'derive',cell(1,n));
    
    % assert
    assert(iseven(nargin),'nnet_create: error. need even number of input arguments');
    assert(iscellstr(var),'nnet_create: error. one or more [var#] are not strings');
    
    % create layers
    for i = 1:n
        type = var{i};
        pars = val{i};
        switch type
        % linear operations
            case 'dot',         [output,derive] = nnet_layer_dot();
            case 'batchdot',    [output,derive] = nnet_layer_batchdot();
            case 'sum',         [output,derive] = nnet_layer_sum();
        % non-linear operations
%             case 'softmax',     [output,derive] = nnet_layer_softmax();
            case 'sigmoid',     [output,derive] = nnet_layer_sigmoid();
            case 'relu',        [output,derive] = nnet_layer_relu();
        % losses
            case 'sqeuclidean', [output,derive] = nnet_layer_sqeuclidean();
            % case 'euclidean',   [output,derive] = nnet_layer_euclidean();
            % case 'xentropy',    [output,derive] = nnet_layer_xentropy();
        % shrink batch
            case 'sumbatch',    [output,derive] = nnet_layer_sumbatch();
%             case 'meanbatch',   [output,derive] = nnet_layer_meanbatch();
            otherwise,      error('nnet_create: error. layer "%s" not valid',type);
        end
        nnet(i) = struct('type',{type},'parameters',{pars},'output',{output},'derive',{derive});
    end
end

%% auxiliar (linear operations)

% dot (matrix product)
function [output,derive] = nnet_layer_dot()
    function y = func_output(l,x,i)
        [w] = func_deal(l.parameters{:});
        y = x * w;
    end
    function d = func_derive(l,x,y,e,i)
        [w] = func_deal(l.parameters{:});
        d = {e * w', x' * e};
    end
    output = @func_output;
    derive = @func_derive;
end

% batchdot (matrix product, with different for each sample within the batch)
function [output,derive] = nnet_layer_batchdot()
    function y = func_output(l,x,i)
        [w] = func_deal(l.parameters{:});
        assert(size(w,3) == size(x,1),'nnet_layer_batchdot: func_output: error. [w] and [x] do not match');
        y = nan([size(x,1),size(w,2)]);
        for k = 1:size(w,3)
            y(k,:) = x(k,:) * w(:,:,k);
        end
    end
    function d = func_derive(l,x,y,e,i)
        [w] = func_deal(l.parameters{:});
        d = cell(1,2);
        d{1} = nan([size(e,1),size(w,1)]);
        d{2} = repmat(x'*e, [1,1,size(w,3)]);
        for k = 1:size(w,3)
            d{1}(k,:) = e(k,:)*w(:,:,k)';
            xx = zeros(size(x));
            xx(k,:) = x(k,:);
            d{2}(:,:,k) = xx' * e;
        end
    end
    output = @func_output;
    derive = @func_derive;
end

% sum (biases)
function [output,derive] = nnet_layer_sum()
    function y = func_output(l,x,i)
        [b] = func_deal(l.parameters{:});
        y = x + repmat(b,[size(x,1),1]);
    end
    function d = func_derive(l,x,y,e,i)
        d = {e, sum(e,1)};
    end
    output = @func_output;
    derive = @func_derive;
end

%% auxiliar (nonlinear operations)

% % softmax
% function [output,derive] = nnet_layer_softmax()
%     function y = func_output(l,x,i)
%         x(~x(:)) = nan;
%         z = [1,size(x,2)];
%         m = x - repmat(max(x,[],2),z);
%         q = exp(m);
%         s = repmat(nansum(q,2),z);
%         y = q ./ s;
%         y(isnan(y(:))) = 0;
%     end
%     function d = func_derive(l,x,y,e,i) % taken from tensorflow "nn_grad.py"
%         d = {e - repmat(sum(e .* y, 1), [size(y,1), 1]) .* y};
%     end
%     output = @func_output;
%     derive = @func_derive;
% end

% sigmoid
function [output,derive] = nnet_layer_sigmoid()
    function y = func_output(l,x,i)
        y = 1 ./ (1 + exp(-x));
    end
    function d = func_derive(l,x,y,e,i)
        d = {e .* (1 - y) .* y};
    end
    output = @func_output;
    derive = @func_derive;
end


% log
function [output,derive] = nnet_layer_relu()
    function y = func_output(l,x,i)
        y = x .* double(x > 0);
    end
    function d = func_derive(l,x,y,e,i)
        d = { e .* double(x > 0) };
    end
    output = @func_output;
    derive = @func_derive;
end

%% auxiliar (losses)

% sqeuclidean (squared euclidean, MSE)
function [output,derive] = nnet_layer_sqeuclidean()
    function y = func_output(l,x,i)
        e = (x - i);
        y = sum(e.*e, 2);
    end
    function d = func_derive(l,x,y,e,i)
        e = (x - i);
        d = {2 * e};
    end
    output = @func_output;
    derive = @func_derive;
end

% euclidean (squared root of MSE)
% function [output,derive] = nnet_layer_euclidean()
%     function y = func_output(l,x,i)
%         e = (x - i);
%         y = sqrt(sum(e.*e, 2));
%     end
%     function d = func_derive(l,x,y,e,i)
%         e = (x - i);
%         d = {e ./ repmat(y,[1,size(e,2)])};
%         error('TO CHECK');
% 
%     end
%     output = @func_output;
%     derive = @func_derive;
% end

% xentropy (cross-entropy)
% function [output,derive] = nnet_layer_xentropy()
%     function y = func_output(l,x,i)
%         y = sum(l .* log(x), 2);
%     end
%     function d = func_derive(l,x,y,e,i)
%         error('TODO');
%     end
%     output = @func_output;
%     derive = @func_derive;
% end

%% auxiliar (shrink batch)

% sumbatch
function [output,derive] = nnet_layer_sumbatch()
    function y = func_output(l,x,i)
        y = sum(x,1);
    end
    function d = func_derive(l,x,y,e,i)
        m = size(x,1);
        d = {e * ones(m,1)};
    end
    output = @func_output;
    derive = @func_derive;
end

% % meanbatch
% function [output,derive] = nnet_layer_meanbatch()
%     function y = func_output(l,x,i)
%         y = mean(x,1);
%     end
%     function d = func_derive(l,x,y,e,i)
%         m = size(x,1);
%         d = {e * ones(m,1) ./ m};
%     end
%     output = @func_output;
%     derive = @func_derive;
% end

