
function installed = scan_glm_tfce_installed()
    %% installed = SCAN_GLM_TFCE_INSTALLED()
    % is installed the TFCE-toolbox, by Christian Gaser?
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % return
    installed = logical(exist('spm_TFCE.m'));
end
