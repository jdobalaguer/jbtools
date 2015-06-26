
function binaryMask = scan_tool_rsa_fMRIMaskPreparation(scan,i_subject)
    %% binaryMask = SCAN_TOOL_RSA_FMRIMASKPREPARATION(scan,i_subject)
    % RSA toolbox - fMRIMaskPreparation
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    binaryMask = reshape(scan.running.mask(i_subject).mask,scan.running.mask(i_subject).shape);
end
