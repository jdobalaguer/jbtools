
function [v,s] = scan_nifti_load(file,mask)
    %% [v,s] = SCAN_NIFTI_LOAD(file[,mask])
    % Load a NIFTI image
    % see also scan_plot_peristimulus
    
    %% WARNINGS
    %#ok<*ERTAG,*FPARK>

    %% FUNCTION
    
    % mask
    not_mask = [];
    if exist('mask','var') && ~isempty(mask), not_mask = ~mask(:); end
    
    % volume
    v = spm_vol(file);
    s = size(v.private.dat);
    v = double(v.private.dat(:));
    v(not_mask) = [];

end
