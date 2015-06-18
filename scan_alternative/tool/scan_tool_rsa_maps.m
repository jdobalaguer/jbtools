
function toolbox = scan_tool_rsa_maps(scan,toolbox,i_subject,i_session)
    %% toolbox = SCAN_TOOL_RSA_MAPS(scan,toolbox,i_subject,i_session)
    % RSA toolbox - save maps
    % to list main functions, try
    %   >> help scan;
    
    %% function

    for i_model = 1:numel(scan.job.model)
        
        % directories & files
        file_rmap_image  = fullfile(scan.running.directory.map.session{i_model}{i_subject}{i_session},'image', 'rmap.img');
        file_rmap_smooth = fullfile(scan.running.directory.map.session{i_model}{i_subject}{i_session},'smooth','rmap.img');
        file_pmap_image  = fullfile(scan.running.directory.map.session{i_model}{i_subject}{i_session},'image', 'pmap.img');
        file_pmap_smooth = fullfile(scan.running.directory.map.session{i_model}{i_subject}{i_session},'smooth','pmap.img');
        file_mkdir(fileparts(file_rmap_image));
        file_mkdir(fileparts(file_rmap_smooth));

        % save raw maps
        meta = scan.running.meta;
        scan_nifti_save(file_rmap_image,toolbox.result.rs(:,:,:,i_model),meta);
        scan_nifti_save(file_pmap_image,toolbox.result.ps(:,:,:,i_model),meta);

        % save smooth maps
        spm_smooth(file_rmap_image,file_rmap_smooth,[10 10 10]);
        spm_smooth(file_pmap_image,file_pmap_smooth,[10 10 10]);
    end
end
