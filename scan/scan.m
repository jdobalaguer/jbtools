
function scan()
    %% SCAN toolbox (for fMRI data with SPM)
    %
    % scan_conversion    : convert dicom, nifti-4d and nifti-3d
    % scan_preprocess    : run a preprocessing pipeline
    % scan_glm           : GLM / PPI analysis
    % scan_tbte          : trial-by-trial estimates
    % scan_rsa           : representation similarity analysis

    % scan_mvpa          : multivoxel pattern analysis
    
    %% function
    tcan.parameter.analysis = struct('wpause',false,'verbose',true,'color',struct('warning',[1,0.5,0]));
    scan_tool_warning(tcan,false,'[scan] variable not defined.');
    scan_tool_warning(tcan,false,'displaying help');
    help(which('scan'));
end
