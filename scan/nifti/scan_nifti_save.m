
function scan_nifti_save(file,vol,template)
    %% SCAN_NIFTI_SAVE(file,vol,template)
    % save a NIFTI image
    % see also scan_plot_peristimulus
    
    %% WARNINGS
    %#ok<*ERTAG,*FPARK>

    %% FUNCTION
    
    % template
    if isstr(template), template = spm_vol(template); end
    
    % file
    template.fname = file;
    
    % volume
    assert(numel(vol)==numel(double(template.private.dat)), 'scan_nifti_save: error. wrong numel');
    vol = reshape(vol,template.dim);
    
    % write
    spm_write_vol(template,vol);

end
