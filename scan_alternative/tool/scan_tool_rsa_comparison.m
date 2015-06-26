
function [z,p] = scan_tool_rsa_comparison(scan,rdm,models)
    %% [r,p] = SCAN_TOOL_RSA_COMPARISON(comparison,rdm,models)
    % RSA toolbox - create RDM
    % to list main functions, try
    %   >> help scan;
    
    %% function
    switch scan.job.comparison
        case {'pearson','spearman','kendall'}
            [z,p] = corr(mat2vec(rdm),models,'type',scan.job.comparison,'rows','pairwise');
            z = atanh(z);
        case 'glm'
            models = mat_zscore(models,1);
            rdm    = mat_zscore(mat2vec(rdm));
            scan_tool_assert(scan,~anynan(models),'cannot run glm (one or more models is constant).');
            z = pinv(models)*rdm;
            p = nan(size(z));
        otherwise
            scan_tool_error(scan,'comparison "%s" is not valid',scan.job.comparison);
    end
end
