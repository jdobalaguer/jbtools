
function scan = scan_rsa_searchlight_first(scan)
    %% scan = SCAN_RSA_SEARCHLIGHT_FIRST(scan)
    % RSA first-level analysis (searchlight)
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % this may fail when using native spaces
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.first, return; end
    
    % print
    scan_tool_print(scan,false,'\nRSA analysis (first level) : ');
    scan = scan_tool_progress(scan,scan.running.subject.number*numel(scan.job.model));

    
    % first-level analysis
    for i_model = 1:numel(scan.job.model)
        for i_subject = 1:scan.running.subject.number
            
            % list files
            first_rmap_image  = fullfile(scan.running.directory.first.correlation,scan.job.model(i_model).name,sprintf('image subject_%03i.nii', scan.running.subject.unique(i_subject)));
            first_rmap_smooth = fullfile(scan.running.directory.first.correlation,scan.job.model(i_model).name,sprintf('smooth subject_%03i.nii',scan.running.subject.unique(i_subject)));
            file_mkdir(fileparts(first_rmap_image));
            
            % group volumes
            [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
            [group_image_rs,group_smooth_rs] = deal(nan(n_session,prod(scan.running.meta.dim)));
            for i_session = 1:n_session
                group_image_rs (i_session,:) = mat2vec(scan.result.zero{i_subject}{i_session}.image.rs (:,:,:,i_model));
                group_smooth_rs(i_session,:) = mat2vec(scan.result.zero{i_subject}{i_session}.smooth.rs(:,:,:,i_model));
            end
            mean_image_rs  = nanmean(group_image_rs, 1);
            mean_smooth_rs = nanmean(group_smooth_rs,1);
            
            % write
            meta = struct_rm(scan.running.meta,'pinfo');
            meta.descrip = 'R-map';
            scan_nifti_save(first_rmap_image, mean_image_rs, meta);
            scan_nifti_save(first_rmap_smooth,mean_smooth_rs,meta);
            
            % save
            scan.result.first{i_subject}.image.rs(:,:,:,i_model) = reshape(mean_image_rs,meta.dim);
            scan.result.first{i_subject}.smooth.rs(:,:,:,i_model) = reshape(mean_smooth_rs,meta.dim);
            
            % wait
            scan = scan_tool_progress(scan,[]);
        end
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
