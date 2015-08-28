
function scan_nifti_save(file,vol,template)
    %% SCAN_NIFTI_SAVE(file,vol,template)
    % save a NIFTI image
    % see also scan_plot_peristimulus
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % template
    if ischar(template), template = spm_vol(template); end
    
    % remove pinfo
    template = struct_rm(template,'pinfo');
    
    % file
    template.fname = file;
    
    % volume
    vol = reshape(vol,template.dim);
    
    % write
    spm_write_vol(template,vol);

end
