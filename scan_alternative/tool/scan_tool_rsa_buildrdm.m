
function rdm = scan_tool_rsa_buildrdm(scan,beta,X,Y)
    %% rdm = SCAN_TOOL_RSA_BUILDRDM(scan,beta)
    % RSA toolbox - create RDM
    % to list main functions, try
    %   >> help scan;
    
    %% function
    switch scan.job.distance
        case {'euclidean','seuclidean','cityblock','minkowski','chebychev','cosine','correlation','spearman','hamming','jaccard'}
            rdm = pdist(beta,scan.job.distance);
        case 'mahalanobis'
            scan_tool_assert(scan,~strcmp(scan.job.transformation,'mean'),'dude, using mahalanobis distance of a mean doesn''t make any sense. are you sure you know what you''re doing?');
            rdm = pdist(beta*covdiag(Y-X*(X\Y)),'euclidean');
        otherwise
            scan_tool_error(scan,'distance "%s" is not valid',scan.job.distance);
    end
end
