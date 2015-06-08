
function scan = scan_autocomplete_rsa(scan)
    %% scan = SCAN_AUTOCOMPLETE_RSA(scan)
    % autocomplete [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    scan.running.directory.job = file_endsep(fullfile(scan.directory.(scan.job.type),scan.job.name));
    
    % glm
    scan.running.glm = file_loadvar(fullfile(scan.directory.(scan.job.glm.type),scan.job.glm.name,'scan.mat'),'scan');
    
    % load
    scan.running.load = struct();
    
    % mask
    scan.running.mask = struct('name',{},'mask',{},'main',{},'voxel',{});
    for i_mask = 1:length(scan.job.mask)
        scan.running.mask(i_mask) = struct('name',scan.job.mask(i_mask),'mask',{scan_nifti_load(fullfile(scan.directory.mask,scan.job.mask{i_mask}))},'main',scan.job.mask(i_mask),'voxel',{nan});
    end
end
