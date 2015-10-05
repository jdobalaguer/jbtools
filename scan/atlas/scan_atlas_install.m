
function scan = scan_atlas_install(scan,atlas)
    %% scan = SCAN_ATLAS_INSTALL(scan)
    % download/install an atlas
    % atlas : one string, one of {'AAL','AAL2','TD','xjview'}
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % default
    func_default('atlas','AAL2');
    
    % paths
    path_private      = fullfile(scan_atlas_root(),'private');
    path_atlas        = file_endsep(fullfile(path_private,'atlas'));
    path_atlas_atlas  = file_endsep(fullfile(path_atlas,atlas));
    path_trash        = file_endsep(fullfile(path_private,'trash'));
    path_trash_atlas  = file_endsep(fullfile(path_trash,atlas));
    
    % set URL
    switch atlas
        case 'AAL',     url = {'http://www.gin.cnrs.fr/AAL_files/aal_for_SPM12.tar.gz'};
        case 'AAL2',    url = {'http://www.gin.cnrs.fr/AAL2_files/aal2_for_SPM12.tar.gz'};
        case 'TD',      url = {'http://www.talairach.org/talairach.nii','http://www.talairach.org/labels.txt'};
        case 'xjview',  url = {'http://www.alivelearn.net/xjview8/TDdatabase.mat'};
        otherwise
            scan_tool_error(scan,'atlas "%s" not recognised',atlas);
    end
    
    % print
    scan_tool_print(scan,false,'Installing %s atlas from "%s"',atlas,url{1});
    for i = 2:length(url), scan_tool_print(scan,false,'                         "%s"',atlas,url{i}); end
    scan = scan_tool_progress(scan,5);
    
    % create trash, delete old versions
    file_mkdir(path_trash_atlas);
    file_rmdir(path_atlas_atlas);
    scan = scan_tool_progress(scan,[]);
    
    % download and extract
    switch atlas
        case {'AAL','AAL2'}
            untar(url{1},path_trash_atlas);
        case {'TD','xjview'}
            for i = 1:length(url), urlwrite(url{i},fullfile(path_trash_atlas,file_2local(url{i}))); end
    end
    scan = scan_tool_progress(scan,[]);
    
    % install interesting files
    file_mkdir(path_atlas_atlas);
    switch atlas
        case 'AAL'
            aal2nii( path_trash_atlas,path_atlas_atlas,'ROI_MNI_V4');
            aal2list(path_trash_atlas,path_atlas_atlas,'ROI_MNI_V4');
        case 'AAL2'
            aal2nii( path_trash_atlas,path_atlas_atlas,'ROI_MNI_V5');
            aal2list(path_trash_atlas,path_atlas_atlas,'ROI_MNI_V5');
        case 'TD'
            scan_tool_error(scan,'TODO: transform tailarach to MNI, and save with format');
            td2nii();
            td2list();
        case 'xjview'
            DB = file_loadvar(fullfile(path_trash_atlas,'TDdatabase.mat'),'DB');
            for i_DB = 1:length(DB)
                xjview2nii(DB{i_DB},path_atlas_atlas);  ... save NIfTI
                xjview2list(DB{i_DB},path_atlas_atlas); ... save list
            end
    end
    scan = scan_tool_progress(scan,[]);
    
    % delete trash
    file_rmdir(path_trash);
    scan = scan_tool_progress(scan,[]);
    
    % end of progress
    scan = scan_tool_progress(scan,[]);
    scan = scan_tool_progress(scan,0);
end

%% auxiliar aal

% save an AAL volume
function aal2nii(path_trash_atlas,path_atlas_atlas,file)
    file = sprintf('%s.nii',file);
    copyfile(fullfile(path_trash_atlas,'aal',file),fullfile(path_atlas_atlas,file));
end

% save an AAL list
function aal2list(path_trash_atlas,path_atlas_atlas,file)
    ROI = file_loadvar(fullfile(path_trash_atlas,'aal',sprintf('%s_List.mat',file)),'ROI');
    list = struct('id',{ROI.ID},'label',{ROI.Nom_L});
    % TODO: extend ROI mat (with combinations of ROIs)
    file = fullfile(path_atlas_atlas,sprintf('%s.mat',file));
    file_savevar(file,'','list',list);
end

%% auxiliar TD

function td2nii()
end
function td2list()
end

%% auxiliar xjview

% save an xjview volume
function xjview2nii(DB,path_atlas_atlas)
    meta = struct();
    meta.fname   = fullfile(path_atlas_atlas,sprintf('%s.nii',DB.type));
    meta.dim     = [91,109,91];
    meta.dt      = [4,1];
    meta.mat     = [-2,0,0,92;0,2,0,-128;0,0,2,-74;0,0,0,1];
    meta.descrip = '';
    scan_nifti_save(meta.fname,DB.mnilist,meta);
end

% save an xjview list
function xjview2list(DB,path_atlas_atlas)
    id    = num2cell(1:length(DB.anatomy));
    label = DB.anatomy;
    list  = struct('id',id,'label',label);
    file  = fullfile(path_atlas_atlas,sprintf('%s.mat',DB.type));
    file_savevar(file,'','list',list);
end

