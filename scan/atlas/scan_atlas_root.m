
function root = scan_atlas_root()
    %% root = SCAN_ATLAS_ROOT()
    % root folder of the scan_atlas tool

    %% function
    root = file_parts(which('scan_atlas_root'));
end