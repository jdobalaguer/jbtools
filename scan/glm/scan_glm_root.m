
function root = scan_glm_root()
    %% root = SCAN_GLM_ROOT()
    % root folder of the scan_glm tool

    %% function
    root = file_parts(which('scan_glm_root'));
end