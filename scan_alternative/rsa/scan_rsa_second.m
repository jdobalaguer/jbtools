
function scan = scan_rsa_second(scan)
    %% scan = SCAN_RSA_SECOND(scan)
    % RSA second-level analysis
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.second, return; end
    
    % print
    scan_tool_print(scan,false,'\nRSA analysis (second level) : ');
    scan_tool_progress(scan,numel(scan.job.model));
    
    % second-level analysis
    for i_model = 1:numel(scan.job.model)
        
        % list files
        second_rmap_image  = fullfile(scan.running.directory.second.correlation,sprintf('image %s.nii', scan.job.model(i_model).name));
        second_rmap_smooth = fullfile(scan.running.directory.second.correlation,sprintf('smooth %s.nii',scan.job.model(i_model).name));
        second_tmap_image  = fullfile(scan.running.directory.second.tStatistic, sprintf('image %s.nii', scan.job.model(i_model).name));
        second_tmap_smooth = fullfile(scan.running.directory.second.tStatistic, sprintf('smooth %s.nii',scan.job.model(i_model).name));
        second_pmap_image  = fullfile(scan.running.directory.second.probability,sprintf('image %s.nii', scan.job.model(i_model).name));
        second_pmap_smooth = fullfile(scan.running.directory.second.probability,sprintf('smooth %s.nii',scan.job.model(i_model).name));
        file_mkdir(fileparts(second_rmap_image));
        file_mkdir(fileparts(second_tmap_image));
        file_mkdir(fileparts(second_pmap_image));
            
        % group volumes
        [group_image_rs,group_smooth_rs] = deal(nan(scan.running.subject.number,prod(scan.running.meta.dim)));
        for i_subject = 1:scan.running.subject.number
            group_image_rs (i_subject,:) = mat2vec(scan.result.first{i_subject}.image.rs (:,:,:,i_model));
            group_smooth_rs(i_subject,:) = mat2vec(scan.result.first{i_subject}.smooth.rs(:,:,:,i_model));
        end
        mean_image_rs  = nanmean(group_image_rs, 1);
        mean_smooth_rs = nanmean(group_smooth_rs,1);
        
        % t-test
        [~,p_image,~,t_image] = ttest(group_image_rs,[],'tail','right');
        t_image = t_image.tstat;
        t_image(isinf(t_image)) = nan;
        [~,p_smooth,~,t_smooth] = ttest(group_smooth_rs,[],'tail','right');
        t_smooth = t_smooth.tstat;
        t_smooth(isinf(t_smooth)) = nan;
        
        % apply mask
        t_image (isnan(mean_image_rs(:))) = nan;
        p_image (isnan(mean_image_rs(:))) = nan;
        t_smooth(isnan(mean_image_rs(:))) = nan;
        p_smooth(isnan(mean_image_rs(:))) = nan;
        
        % write
        meta = scan.running.meta;
        meta.descrip = 'R-map';
        scan_nifti_save(second_rmap_image, mean_image_rs, meta);
        scan_nifti_save(second_rmap_smooth,mean_smooth_rs,meta);
        meta.descrip = sprintf('SPM{T_[%.1f]} - contrast 1: %s',scan.running.subject.number-1,scan.job.model(i_model).name);
        scan_nifti_save(second_tmap_image, t_image, meta);
        scan_nifti_save(second_tmap_smooth,t_smooth,meta);
        meta.descrip = 'P-map';
        scan_nifti_save(second_pmap_image, p_image, meta);
        scan_nifti_save(second_pmap_smooth,p_smooth,meta);
        
        % save
        scan.result.second.image.rs(:,:,:,i_model)  = reshape(mean_image_rs,meta.dim);
        scan.result.second.smooth.rs(:,:,:,i_model) = reshape(mean_smooth_rs,meta.dim);
        scan.result.second.image.ts(:,:,:,i_model)  = reshape(t_image,meta.dim);
        scan.result.second.smooth.ts(:,:,:,i_model) = reshape(t_smooth,meta.dim);
        scan.result.second.image.ps(:,:,:,i_model)  = reshape(p_image,meta.dim);
        scan.result.second.smooth.ps(:,:,:,i_model) = reshape(p_smooth,meta.dim);
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
