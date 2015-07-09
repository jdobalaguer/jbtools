
function beta = scan_tool_rsa_transformation(scan,beta)
    %% beta = SCAN_TOOL_RSA_TRANSFORMATION(scan,beta)
    % RSA toolbox - transform betas
    % to list main functions, try
    %   >> help scan;
    
    %% function
    switch scan.job.transformation
        case 'none'
        case 'mean'
            beta = mean(beta,2);
        case 'demean'
            beta = mat_demean(beta,2);
        case 'zscore'
            beta = mat_zscore(beta,2);
        otherwise
            scan_tool_error(scan,'transformation "%s" not valid',scan.job.transformation);
    end
end
