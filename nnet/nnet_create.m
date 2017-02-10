
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
%             case 'batchdot',    [output,derive] = nnet_layer_batchdot();
            case 'sum',         [output,derive] = nnet_layer_sum();
        % non-linear operations
            case 'eye',         [output,derive] = nnet_layer_eye();
            case 'softmax',     [output,derive] = nnet_layer_softmax();
            case 'sigmoid',     [output,derive] = nnet_layer_sigmoid();
            case 'tanh',        [output,derive] = nnet_layer_tanh();
            case 'relu',        [output,derive] = nnet_layer_relu();
            case 'sqrt',        [output,derive] = nnet_layer_sqrt();
            case 'abs',         [output,derive] = nnet_layer_abs();
            case 'sin',         [output,derive] = nnet_layer_sin();
            case 'janu',        [output,derive] = nnet_layer_janu();
        % losses
            case 'sqeuclidean', [output,derive] = nnet_layer_sqeuclidean();
            case 'euclidean',   [output,derive] = nnet_layer_euclidean();
            case 'xentropy',    [output,derive] = nnet_layer_xentropy();
            case 'loglhood',    [output,derive] = nnet_layer_loglhood();
        % shrink batch
            case 'sumbatch',    [output,derive] = nnet_layer_sumbatch();
            case 'meanbatch',   [output,derive] = nnet_layer_meanbatch();
            otherwise,      error('nnet_create: error. layer "%s" not valid',type);
        end
        nnet(i) = struct('type',{type},'parameters',{pars},'output',{output},'derive',{derive});
    end
end

%% auxiliar (linear operations)

% eye (identity)
function [output,derive] = nnet_layer_eye()
    function y = func_output(l,x,i)
        y = x;
    end
    function d = func_derive(l,x,y,e,i)
        d = {e};
    end
    output = @func_output;
    derive = @func_derive;
end

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

% % batchdot (matrix product, with different for each sample within the batch)
% function [output,derive] = nnet_layer_batchdot()
%     function y = func_output(l,x,i)
%         [w] = func_deal(l.parameters{:});
%         assert(size(w,3) == size(x,1),'nnet_layer_batchdot: func_output: error. [w] and [x] do not match');
%         y = nan([size(x,1),size(w,2)]);
%         for k = 1:size(w,3)
%             y(k,:) = x(k,:) * w(:,:,k);
%         end
%     end
%     function d = func_derive(l,x,y,e,i)
%         [w] = func_deal(l.parameters{:});
%         d = cell(1,2);
%         d{1} = nan([size(e,1),size(w,1)]);
%         d{2} = repmat(x'*e, [1,1,size(w,3)]);
%         for k = 1:size(w,3)
%             d{1}(k,:) = e(k,:)*w(:,:,k)';
%             xx = zeros(size(x));
%             xx(k,:) = x(k,:);
%             d{2}(:,:,k) = xx' * e;
%         end
%     end
%     output = @func_output;
%     derive = @func_derive;
% end

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

% softmax
function [output,derive] = nnet_layer_softmax()
    function y = func_output(l,x,i)
        x(~x(:)) = nan;
        z = [1,size(x,2)];
        m = x - repmat(max(x,[],2),z);
        q = exp(m);
        s = repmat(nansum(q,2),z);
        y = q ./ s;
        y(isnan(y(:))) = 0;
    end
    function d = func_derive(l,x,y,e,i)
        % see "http://stackoverflow.com/questions/33541930/how-to-implement-the-softmax-derivative-independently-from-any-loss-function"
        dx = y .* e;
        d = {dx - (y.* repmat(sum(dx,2),[1,size(dx,2)]))};
    end
    output = @func_output;
    derive = @func_derive;
end

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

% tanh
function [output,derive] = nnet_layer_tanh()
    function y = func_output(l,x,i)
        y = tanh(x);
    end
    function d = func_derive(l,x,y,e,i)
        d = {e .* (1 - y.*y)};
    end
    output = @func_output;
    derive = @func_derive;
end

% relu
function [output,derive] = nnet_layer_relu()
    function y = func_output(l,x,i)
        y = x .* double(x > 0);
    end
    function d = func_derive(l,x,y,e,i)
        d = {e .* double(x > 0) };
    end
    output = @func_output;
    derive = @func_derive;
end

% sqrt (square root)
function [output,derive] = nnet_layer_sqrt()
    function y = func_output(l,x,i)
        y = sqrt(x);
        y(x<=0) = nan;
    end
    function d = func_derive(l,x,y,e,i)
        d = {e ./ 2 ./ y };
    end
    output = @func_output;
    derive = @func_derive;
end

% abs (absolute value)
function [output,derive] = nnet_layer_abs()
    function y = func_output(l,x,i)
        y = abs(x);
    end
    function d = func_derive(l,x,y,e,i)
        d = {e .* sign(x)};
    end
    output = @func_output;
    derive = @func_derive;
end

% sin (trigonometric sinus)
function [output,derive] = nnet_layer_sin()
    function y = func_output(l,x,i)
        y = sin(x);
    end
    function d = func_derive(l,x,y,e,i)
        d = {e .* cos(x)};
    end
    output = @func_output;
    derive = @func_derive;
end

% janu (jan's unit)
function [output,derive] = nnet_layer_janu()
    function y = func_output(l,x,i)
        y = abs(mod(x+1,2)-1);
    end
    function d = func_derive(l,x,y,e,i)
        d = {e .* sign(mod(x+1,2)-1)};
    end
    output = @func_output;
    derive = @func_derive;
end

%% auxiliar (losses)

% sqeuclidean (squared euclidean distance)
function [output,derive] = nnet_layer_sqeuclidean()
    function y = func_output(l,x,i)
        dx = (x - i);
        y  = sum(dx.*dx, 2);
    end
    function d = func_derive(l,x,y,e,i)
        d = {repmat(e,[1,size(x,2)]) .* 2 .* (x - i)};
    end
    output = @func_output;
    derive = @func_derive;
end

% euclidean
function [output,derive] = nnet_layer_euclidean()
    function y = func_output(l,x,i)
        dx = (x - i);
        y = sqrt(sum(dx.*dx, 2));
    end
    function d = func_derive(l,x,y,e,i)
        d = {repmat(e,[1,size(x,2)]) .* (x - i) ./ repmat(y,[1,size(x,2)])};
    end
    output = @func_output;
    derive = @func_derive;
end

% xentropy (cross-entropy for softmax)
function [output,derive] = nnet_layer_xentropy()
    function y = func_output(l,x,i)
        y = -sum(i .* log(x), 2);
    end
    function d = func_derive(l,x,y,e,i)
        d = { -repmat(e,[1,size(x,2)]) .* i ./ x };
    end
    output = @func_output;
    derive = @func_derive;
end

% loglhood (log-likelihood for sigmoid)
function [output,derive] = nnet_layer_loglhood()
    function y = func_output(l,x,i)
        y = sum(-(i .* log(x) + (1-i) .* log(1-x)),2);
    end
    function d = func_derive(l,x,y,e,i)
        d = { repmat(e,[1,size(x,2)]) .* (((1-i)./(1-x)) - (i ./ x)) };
    end
    output = @func_output;
    derive = @func_derive;
end


%% auxiliar (shrink batch)

% sumbatch
function [output,derive] = nnet_layer_sumbatch()
    function y = func_output(l,x,i)
        y = sum(x,1);
    end
    function d = func_derive(l,x,y,e,i)
        m = size(x,1);
        d = {repmat(e,[m,1])};
    end
    output = @func_output;
    derive = @func_derive;
end

% meanbatch
function [output,derive] = nnet_layer_meanbatch()
    function y = func_output(l,x,i)
        y = mean(x,1);
    end
    function d = func_derive(l,x,y,e,i)
        m = size(x,1);
        d = {repmat(e,[m,1]) ./ m};
    end
    output = @func_output;
    derive = @func_derive;
end

