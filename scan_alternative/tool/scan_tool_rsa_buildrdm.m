
function rdm = scan_tool_rsa_buildrdm(scan,beta)
    %% rdm = SCAN_TOOL_RSA_BUILDRDM(scan,beta)
    % RSA toolbox - create RDM
    % to list main functions, try
    %   >> help scan;
    
    %% function
    switch scan.job.distance
        case {'euclidean','seuclidean','cityblock','minkowski','chebychev','cosine','correlation','spearman','hamming','jaccard'}
            rdm = pdist(beta,scan.job.distance);
        case 'mahalanobis'
            scan_tool_assert(scan,~scan.job.univariate,'dude, univariate and mahalanobis doesn''t make sense. do you know what you''re doing?');
            scan_tool_error(scan,'not implemented yet');
        otherwise
            scan_tool_error(scan,'distance "%s" is not valid',scan.job.distance);
    end
end
