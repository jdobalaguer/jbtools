
function z = mme_for(varargin)
    %% MME_FOR(f,p,x1[,x2][,..])
    % combine multiple loops within a single parfor
    % use global variables or nested functions to share information with [f]
    %
    % f  : function with inputs ({x#},{i#}) for each iteration
    % p  : use parfor (default true)
    % x# : iterations for each condition
    % z  : resulting cell tensor

    %% notes
    % it seems like this may not be optimal (see 
    % 
    
    %% function
    
    % arguments
    [f,p,x] = deal(varargin{1},varargin{2},varargin(3:end));
    
    % default
    func_default('p',true);
    if ~exist('gcp','file'), p = false; end
    
    % assert
    assertVector(x{:});
    
    % transform to cell
    ii_cell = cellfun(@iscell,x);
    x(~ii_cell) = cellfun(@(x)num2cell(x),x(~ii_cell),'UniformOutput',false);
    
    % indices
    i = cellfun(@(x)1:numel(x),x,'UniformOutput',false);
    s = cellfun(@(x)numel(x),x);
    n = length(s);
    
    % combine x
    i = fliplr(vec_combination(i{n:-1:1}));
    
    % parfor
    z = cell(size(i,1),1);
    if p
        parfor j = 1:size(i,1)
            ti = num2cell(i(j,:));
            tx = cellfun(@(x,i)x{i},x,ti,'UniformOutput',false);
            z{j} = f(tx,ti); %#ok<PFBNS>
        end
    else
        for j = 1:size(i,1)
            ti = num2cell(i(j,:));
            tx = cellfun(@(x,i)x{i},x,ti,'UniformOutput',false);
            z{j} = f(tx,ti);
        end
    end
    
    % reshape
    s(1,end+1:2) = 1;
    z = reshape(z,s);
    
end