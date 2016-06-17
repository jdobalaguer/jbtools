
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
            case 'dot',         [output,derive] = nnet_layer_dot();
%             case 'sum',         [output,derive] = nnet_layer_sum();
%             case 'softmax',     [output,derive] = nnet_layer_softmax();
            case 'sigmoid',     [output,derive] = nnet_layer_sigmoid();
            case 'sqeuclidean', [output,derive] = nnet_layer_sqeuclidean();
%             case 'euclidean',   [output,derive] = nnet_layer_euclidean();
%             case 'xentropy',    [output,derive] = nnet_layer_xentropy();
            case 'sumbatch',    [output,derive] = nnet_layer_sumbatch();
            case 'meanbatch',   [output,derive] = nnet_layer_meanbatch();
            otherwise,      error('nnet_create: error. layer "%s" not valid',type);
        end
        nnet(i) = struct('type',{type},'parameters',{pars},'output',{output},'derive',{derive});
    end
end

%% auxiliar (dot)
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

%% auxiliar (sum)
% function [output,derive] = nnet_layer_sum()
%     function y = func_output(l,x,i)
%         [b] = func_deal(l.parameters{:});
%         y = x + repmat(b,[size(x,1),1]);
%     end
%     function d = func_derive(l,x,y,e,i)
%         d = {e, mean(e,1)};
%         error('TO CHECK');
%     end
%     output = @func_output;
%     derive = @func_derive;
% end

%% auxiliar (softmax)
% function [output,derive] = nnet_layer_softmax()
%     function y = func_output(l,x,i)
%         y = x; % TODO
%     end
%     function d = func_derive(l,x,y,e,i)
%         d = e; % TODO
%     end
%     output = @func_output;
%     derive = @func_derive;
% end

%% auxiliar (sigmoid)
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

%% auxiliar (sqeuclidean)
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

%% auxiliar (euclidean)
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

%% auxiliar (xentropy)
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

%% auxiliar (sumbatch)
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

%% auxiliar (meanbatch)
function [output,derive] = nnet_layer_meanbatch()
    function y = func_output(l,x,i)
        y = mean(x,1);
    end
    function d = func_derive(l,x,y,e,i)
        m = size(x,1);
        d = {e * ones(m,1) ./ m};
    end
    output = @func_output;
    derive = @func_derive;
end

