
function scan = scan_rsa_searchlight_estimation(scan)
    %% scan = SCAN_RSA_SEARCHLIGHT_ESTIMATION(scan)
    % RSA estimation (searchlight)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.estimation, return; end
    
    % print
    scan_tool_print(scan,false,'\nRSA estimation : ');
    scan = scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
        
            % searchlight
            [image_rs,image_ps,image_ns] = scan_tool_rsa_searchlight(scan,i_subject,i_session);
            
            % write & smooth
            smooth_rs = nan(size(image_rs),'single');
            smooth_ps = nan(size(image_rs),'single');
            for i_model = 1:numel(scan.job.model)
                file_rmap_image  = fullfile(scan.running.directory.estimation.correlation,scan.job.model(i_model).name,sprintf('image subject_%03i session_%03i.nii',scan.running.subject.unique(i_subject),i_session));
                file_rmap_smooth = fullfile(scan.running.directory.estimation.correlation,scan.job.model(i_model).name,sprintf('smooth subject_%03i session_%03i.nii',scan.running.subject.unique(i_subject),i_session));
                file_pmap_image  = fullfile(scan.running.directory.estimation.probability,scan.job.model(i_model).name,sprintf('image subject_%03i session_%03i.nii',scan.running.subject.unique(i_subject),i_session));
                file_pmap_smooth = fullfile(scan.running.directory.estimation.probability,scan.job.model(i_model).name,sprintf('smooth subject_%03i session_%03i.nii',scan.running.subject.unique(i_subject),i_session));
                file_mkdir(fileparts(file_rmap_image));
                file_mkdir(fileparts(file_pmap_image));
                meta = scan.running.meta;
                meta.descrip = 'Z-maps';
                scan_nifti_save(file_rmap_image,image_rs(:,:,:,i_model),meta);
                meta.descrip = 'P-maps';
                scan_nifti_save(file_pmap_image,image_ps(:,:,:,i_model),meta);
                spm_smooth(file_rmap_image,file_rmap_smooth,[10 10 10]);
                spm_smooth(file_pmap_image,file_pmap_smooth,[10 10 10]);
                smooth_rs(:,:,:,i_model) = reshape(scan_nifti_load(file_rmap_smooth),scan.running.meta.dim);
                smooth_ps(:,:,:,i_model) = reshape(scan_nifti_load(file_pmap_smooth),scan.running.meta.dim);
            end
            
            % save
            scan.result.zero{i_subject}{i_session}.image.rs  = image_rs;
            scan.result.zero{i_subject}{i_session}.smooth.rs = smooth_rs;
            scan.result.zero{i_subject}{i_session}.image.ps  = image_ps;
            scan.result.zero{i_subject}{i_session}.smooth.ps = smooth_ps;
            scan.result.zero{i_subject}{i_session}.image.ns  = image_ns;
            
            % wait
            scan = scan_tool_progress(scan,[]);
        end
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
