
function nii = scan_nifti_load(file,mask)
    %% nii = SCAN_NIFTI_LOAD(file[,mask])
    % Load a NIFTI image
    % see also scan_plot_peristimulus
    
    %% WARNINGS
    %#ok<*ERTAG,*FPARK>

    %% FUNCTION
    
    % mask
    not_mask = [];
    if exist('mask','var') && ~isempty(mask), not_mask = ~mask(:); end
    
    % volume
    nii = spm_vol(file);
    nii = double(nii.private.dat(:));
    nii(not_mask) = [];

end
