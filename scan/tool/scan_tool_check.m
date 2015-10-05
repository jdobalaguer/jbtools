
function varargout = scan_tool_check(scan,image,mode)
    %% vols = SCAN_TOOL_CHECK(scan,image,mode)
    % display volume images (to check the preprocessing)
    % you can use cells in order to combine multiple images
    % image : what volumes to show (e.g. 'structural:normalisation' or 'epi3:realignment' or 'epi3:smooth')
    % mode  : which volume to pick (one of {'first','last','random','mean','all'}), default 'first'
    % to list main functions, try
    %   >> help scan;

    %% notes
    % 1) we use session 1 for everything. it actually should be concantenating all sessions..
    % 2) we make sure we initialize SPM so that the kernel of the smoothing is updated

    %% function
    
    % default
    func_default('mode','first');
    if ~iscell(image), image = {image}; end
    if ~iscell(mode),  mode  = {mode};  end
    scan_tool_assert(scan,length(image)==length(mode),'number of images and modes must match');
    
    % auto-initialize
    scan = scan_initialize_spm(scan);
    if ~struct_isfield(scan,'running.subject.number')
        scan = scan_initialize(scan);
    end
    
    % get files
    n_image = length(image);
    vols = cell(scan.running.subject.number,1);
    labs = cell(scan.running.subject.number,1);
    for i_subject = 1:scan.running.subject.number
        vols{i_subject} = {};
        labs{i_subject} = {};
        for i_image = 1:n_image
            t_vols = get_volume(scan,i_subject,image{i_image},mode{i_image});
            vols{i_subject}(end+1:end+length(t_vols)) = t_vols;
            labs{i_subject}(end+1:end+length(t_vols)) = image(i_image);
        end
    end
    
    % return output
    if nargout, varargout = {vols}; return; end
    
    % display
    check_registration(scan,vols,labs);
end

%% auxiliar (get volume for each subject)
function vol = get_volume(scan,i_subject,image,mode)
    subject = scan.running.subject.unique(i_subject);
    
    % get file
    switch(image)
        case 'structural:image'
            vol = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'structural','image','*.nii'),'absolute');
        case 'structural:coregistration'
            vol = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'structural','coregistration','*.nii'),'absolute');
        case 'structural:segmentation'
            vol = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'structural','segmentation','c*.nii'),'absolute');
        case 'structural:normalisation'
            vol = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'structural','normalisation',num2str(scan.parameter.analysis.voxs),'*.nii'),'absolute');
        case 'epi3:image'
            vol = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'epi3',scan.parameter.path.session{1},'image','*.nii'),'absolute');
        case 'epi3:realignment'
            vol = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'epi3',scan.parameter.path.session{1},'realignment','*.nii'),'absolute');
        case 'epi3:normalisation'
            vol = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'epi3',scan.parameter.path.session{1},'normalisation',num2str(scan.parameter.analysis.voxs),'*.nii'),'absolute');
        case 'epi3:smooth'
            vol = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'epi3',scan.parameter.path.session{1},'smooth',num2str(scan.parameter.analysis.voxs),num2str(unique(spm_get_defaults('smooth.fwhm'))),'*.nii'),'absolute');
        otherwise
            scan_tool_error(scan,'[image] not valid');
    end
    
    % apply mode
    switch(mode)
        case 'first'
            ii = cellfun(@(f)~isempty(strfind(f,'mean')),vol);
            vol(ii) = [];
            vol = vol(1);
        case 'last'
            ii = cellfun(@(f)~isempty(strfind(f,'mean')),vol);
            vol(ii) = [];
            vol = vol(end);
        case 'random'
            vol = randsample(vol,1);
        case 'mean'
            ii = cellfun(@(f)~isempty(strfind(f,'mean')),vol);
            vol = vol(ii);
            scan_tool_assert(scan,length(vol),'subject %03i has %d volumes "%s" (%s)',subject,length(vol),image,mode);
        case 'all'
        otherwise
            scan_tool_error(scan,'[mode] not valid');
    end
end

%% auxiliar (modified from SPM's @spm_check_registration)
function check_registration(scan,vols,labs)
    % $Id: spm_check_registration.m 5944 2014-04-09 17:10:08Z guillaume $
    
    % assert
    n_vols = cellfun(@numel,vols);
    max_vols = 200;
    scan_tool_assert(scan,sum(n_vols)<=max_vols,sprintf('too many volumes (limit is %d)',max_vols));

    % load images
    vols = cellfun(@spm_vol,vols,'UniformOutput',false);
    
    % open window
    spm_figure('GetWin','Graphics');
    spm_figure('Clear','Graphics');
    spm_orthviews('Reset');

    % set grid
    m = length(vols);
    n = max(n_vols);
    w  = 1/n;
    h  = 1/m;
    ds = (w+h)*0.005;
    
    % display volumes
    for i_subject = 1:length(vols)
        subject = scan.running.subject.unique(i_subject);
        for i_image = 1:length(vols{i_subject})
            ij = i_image + length(vols{i_subject})*(i_subject-1);
            i  = 1-h*(floor((ij-1)/n)+1);
            j  = w*rem(ij-1,n);
            handle = spm_orthviews('Image',vols{i_subject}{i_image},[j+ds/2 i+ds/2 w-ds h-ds]);
            if i_subject == 1 && i_image == 1, spm_orthviews('Space'); end
            spm_orthviews('AddContext',handle);
            if i_subject>1  && i_image==1, spm_orthviews('Caption',handle,sprintf('Subject %03i',subject)); end
            if i_subject==1 && i_image==1, spm_orthviews('Caption',handle,sprintf('Subject %03i %s',subject,labs{1}{i_image})); end
            if i_subject==1 && i_image>1,  spm_orthviews('Caption',handle,sprintf('%s',labs{1}{i_image})); end
        end
    end
end
