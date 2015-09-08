
function [z,p] = scan_tool_rsa_comparison(scan,rdm,models,filters)
    %% [z,p] = SCAN_TOOL_RSA_COMPARISON(comparison,rdm,models)
    % RSA toolbox - create RDM
    % to list main functions, try
    %   >> help scan;
    
    %% function
    indices = (~filters);
    switch scan.job.comparison
        case {'pearson','spearman','kendall'}
            % if all models have same filter
            if all(all(bsxfun(@eq,indices,indices(:,1)))) %size(unique(indices','rows'),1)==1 
                indices = all(indices,2);
                [z,p] = corr(mat2vec(rdm(indices)),models(indices,:),'type',scan.job.comparison,'rows','pairwise');
                z = atanh(z);
            % if some models have different filters
            else 
                [z,p] = deal(nan(1,size(models,2)));
                for i_model = 1:size(models,2)
                    [z(i_model),p(i_model)] = corr(mat2vec(rdm(indices(:,i_model))),models(indices(:,i_model),i_model),'type',scan.job.comparison,'rows','pairwise');
                end
                z = atanh(z);
            end
        case 'diff'
            [z,p] = deal(nan(1,size(models,2)));
            for i_model = 1:size(models,2)
%                 ii_filter  = ~filters(:,i_model);
%                 t_model    = logical(models(ii_filter,i_model));
%                 t_rdm      = rdm(ii_filter);
%                 z(i_model) = mean(t_rdm(t_model==1)) - mean(t_rdm(t_model==0));
                z(i_model) = mean(rdm(models(:,i_model)==1)) - mean(rdm(models(:,i_model)==0));
            end
        case 'glm'
            indices = all(indices,2);
            rdm    = rdm(indices);
            models = models(indices,:);
            models = mat_zscore(models,1);
            rdm    = mat_zscore(mat2vec(rdm));
            scan_tool_assert(scan,~anynan(models),'cannot run glm (one or more models is constant or has nans).');
            z = pinv(models)*rdm;
            p = nan(size(z));
            z = atanh(z);
        otherwise
            scan_tool_error(scan,'comparison "%s" is not valid',scan.job.comparison);
    end
end
