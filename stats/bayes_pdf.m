
function varargout = bayes_pdf(x,varargin)
    %% [pdf,z1,..] = BAYES_PDF(x,z1[,z2],[,..])
    % It derives a PDF from the samples [x] (using normal kernel functions).
    % Each row of [x] represents a sample, and each column represents a parameter.
    % You can specify a set of points {z1,z2,..}. when no output, the PDF is plotted.
    % Note: dimensions are assumed to be independent
    % See also bayes
    %          ksdensity

    %% function
    varargout = {};
    
    % default
    n = size(x,2);
    z = varargin;
    z(end+1:n) = {[]};
    
    % get densities
    pdf = cell(1,n);
    for i = 1:n
        if isempty(z{i}), [pdf{i},z{i}] = ksdensity(x(:,i));
        else              pdf{i} = ksdensity(x(:,i),z{i});
        end
    end
    pdf = cellfun(@mat2vec,pdf,'UniformOutput',false);
    
    % make grid pdf
    if n>1, [pdf{1:n}] = meshgrid(pdf{:}); end
    pdf = prod(cat(n+1,pdf{:}),n+1);
    
    % output
    if nargout, varargout = [{pdf},z]; return; end %#ok<VARARG>
    
    % plot
    fig_figure();
    switch(size(x,2))
        case 1
            plot(z{1},pdf,'LineStyle','-','LineWidth',3);
        case 2
            [c,h] = contourf(z{1},z{2},pdf);
            clabel(c,h);
        otherwise
            % We don't plot more than 2 dimensions
    end
end
