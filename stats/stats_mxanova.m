
function varargout = stats_mxanova(x,l)
    %% [h,p,F,stats,terms] = stats_mxanova(x[,l])

    %% notes
    % do i need to specify the subject as a random nested factor?
    
    %% example
    % x = {};
    % x{1} = [repmat(mat2vec(1:32),[4,1]);repmat(mat2vec(33:64),[4,1])];
    % x{2} = repmat(permat([1;2],[128,1]),[ 1,1]);
    % x{3} = repmat(permat([1;2],[ 64,1]),[ 2,1]);
    % x{4} = repmat(permat([1;2],[ 32,1]),[ 4,1]);
    % x = cat(2,x{:});
    % 
    % y = randn(size(x,1),1);
    % y(x(:,2)==1 & x(:,3)==1) = y(x(:,2)==1 & x(:,3)==1) - 1;
    % y(x(:,2)==2 & x(:,3)==1) = y(x(:,2)==2 & x(:,3)==1) + 1;
    % y(x(:,2)==1 & x(:,3)==2) = y(x(:,2)==1 & x(:,3)==2) + 1;
    % y(x(:,2)==2 & x(:,3)==2) = y(x(:,2)==2 & x(:,3)==2) - 1;
    % 
    % nested = zeros(4,4); nested(1,2) = 1;
    % vnames = {'Subject','A','B','C'};
    % [P,T,STATS,TERMS] = anovan(y,x,'random',1,'nested',nested,'varnames',vnames,'model','full');
    % 
    % T(:,[1,3,6,7])

    %% function
    varargout = {};
    
    % default
    n = ndims(x);
    func_default('l',num2cell(char('A'+(0:n-2))));
    
    % assert
    if ismember('Subject',strtrim(l)), func_error('"Subject" is not a valid label'); end
    
    % find random factors
    d = [];
    for i = 2:n
        ii = num2cell(ones(1,n));
        ii{1} = 1:size(x,1);
        ii{i} = 1:size(x,i);
        if all(sum(~isnan(squeeze(x(ii{:}))),2)==1)
            d(end+1) = i;
        end
    end
    clear i ii;
    
    % define grid
    s = size(x);
    t = arrayfun(@(t)1:t,s,'UniformOutput',false);
    [t{1:n}] = ndgrid(t{:});
    t = cellfun(@mat2vec,t,'UniformOutput',false);
    t = cat(2,t{1:end});
    
    % index
    ii = ~isnan(x(:));
    t = t(ii,:);
    x = x(ii);
    
    % labels
    l = [{'Subject'},l];
    
    % effects
    effects = cell(1,numel(l));
    for i = 1:numel(l)
        effects{i} = combnk(l,i);
        effects{i} = mat2cell(effects{i},ones(1,size(effects{i},1)),size(effects{i},2));
    end
    effects = cat(1,effects{:});
    effects = cellfun(@(c)strjoin(c,'*'),effects,'UniformOutput',false);
    
    % ANOVA
    nested = zeros(n); nested(1,d) = 1;
    [p,tbl,stats,terms] = anovan(x,t,'display','off','varnames',l,...
                                     'random',1,'nested',nested,...
                                     'model','full');
    
    % return
    h   = (p < 0.05);
    F   = cell2mat(tbl(2:end-2,6));
    dfd = nan(size(p));
    dfn = cell2mat(tbl(2:end-2,3));
    
    % print
    if ~nargout
        for i = 1:numel(h)
            fprintf('Effect %02d: %-18s F(%3.2f,%3.2f)=%4.3f,\tp=%4.3f \n',i,effects{i},dfn(i),dfd(i),F(i),p(i));
        end
    else
        varargout = {h,p,F,stats,terms};
    end
end
