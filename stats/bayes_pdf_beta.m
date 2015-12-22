
function f = bayes_pdf_beta(varargin)
    %% f = BAYES_PDF_BETA(pars)
    % f = BAYES_PDF_BETA(pars1[,pars2][,..])
    % Returns the handle to a prod(Beta(a,b) or to a
    % prod(Beta(a_i,b_i)) probability density function (PDF)
    %
    % pars : a vector with parameters [a,b]
    % f    : a function with input {z}
    % f    : a function with inputs {z1,z2,..}

    %% function
    u = cellfun(@(pars) @(x)betapdf(x,pars(1),pars(2)),varargin,'UniformOutput',false);
    n = length(u);
    f = @product_pdf;
    
    %% nested
    function p = product_pdf(varargin)
        p = cell(nargin,1);
        for i = 1:nargin
            p{i} = u{i}(mat2vec(varargin{i}));
        end
        p = cat(2,p{:});
        p = prod(p,2);
    end
end

