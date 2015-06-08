
function scan()
    %% SCAN toolbox (for fMRI data with SPM)
    %
    % scan_conversion    : conversion dicom, nifti-4d and nifti-3d
    % scan_preprocess    : run a preprocessing pipeline
    % scan_glm           : GLM and PPI analysis
    % scan_tbte          : trial-by-trial estimates
    % scan_mvpa          : multivoxel pattern analysis
    % scan_rsa           : representation similarity analysis

    %% function
    scan.parameter.analysis = struct('wpause',false,'verbose',true');
    scan_tool_warning(scan,false,'[scan] variable not defined.');
    scan_tool_warning(scan,false,'displaying help');
    help('scan');
end
