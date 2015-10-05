
function vol = scan_atlas_load(scan,atlas,map,roi,ref,interp)
    %% vol = SCAN_ATLAS_LOAD(scan,atlas,map,roi[,ref][,interp])
    % load a mask and reslice it to the corrdinates of a reference volume
    % if [ref] is not specified, reslice is not applied
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
    func_default('interp','');
    
    % path
    path_private      = fullfile(scan_atlas_root(),'private');
    path_atlas        = file_endsep(fullfile(path_private,'atlas'));
    path_atlas_atlas  = file_endsep(fullfile(path_atlas,atlas));
    list_atlas        = fullfile(path_atlas_atlas,sprintf('%s.mat',map));
    nii_atlas         = fullfile(path_atlas_atlas,sprintf('%s.nii',map));
    
    % assert
    scan_tool_assert(scan,~isempty(file_match( nii_atlas)),'cannot find file "%s"', nii_atlas);
    scan_tool_assert(scan,~isempty(file_match(list_atlas)),'cannot find file "%s"',list_atlas);
    
    % load file
    list = file_loadvar(list_atlas,'list');
    nii  = spm_vol(nii_atlas);
    
    % create mask
    vol = struct('fname',{''},'dim',{nii.dim},'dt',{nii.dt},'pinfo',{nii.pinfo},'mat',{nii.mat},'n',{nii.n},'descrip',{''});
    vol.private = struct('dat',{false(vol.dim)});
    ii_label = strcmp({list.label},roi);
    scan_tool_assert(scan,any(ii_label),   'no ROI was found');
    scan_tool_assert(scan,sum(ii_label)==1,'ROI not uniquely specified');
    nii_dat = round(double(nii.private.dat)); ... we need to round it, for the xjview atlas
    vol.private.dat(ismember(nii_dat,list(ii_label).id)) = true;
    
    % no reslice
    if isempty(ref)
        vol = double(vol.private.dat);
        return;
    end
    
    % reslice
    vol = scan_nifti_reslice(vol,ref,interp);
    vol = logical(vol);
end
