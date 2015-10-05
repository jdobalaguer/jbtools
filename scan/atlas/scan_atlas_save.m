
function scan_atlas_save(scan,file,atlas,map,roi,ref,interp)
    %% SCAN_ATLAS_SAVE(scan,file,atlas,map,roi[,ref][,interp])
    % load a mask, reslice it to the corrdinates of a reference volume, and save it to [file]
    % if [ref] is not specified, reslice is not applied
    % file   : file where the anatomical region is saved
    % atlas  : string of a valid atlas (see scan_atlas_list)
    % map    : string of a valid map (see scan_atlas_list)
    % roi    : string of a valid ROI (see scan_atlas_list)
    % ref    : the struct of a volume (see spm_vol)
    % interp : an interpolation method (see scan_nifti_reslice)
    % to list main functions, try
    %   >> help scan;
    

    %% function
    
    % default
    func_default('atlas', '');
    func_default('map',   '');
    func_default('roi',   '');
    func_default('ref',   '');
    if isempty(ref), ref = spm_vol(scan.file.template.t1); end
    func_default('interp','');
    
    % path
    vol = scan_atlas_load(scan,atlas,map,roi,ref,interp);
    
    % save
    scan_nifti_save(file,vol,ref);
end
