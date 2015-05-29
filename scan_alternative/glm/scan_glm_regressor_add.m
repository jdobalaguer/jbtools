
function scan = scan_glm_regressor_add(scan)
    %% scan = SCAN_GLM_REGRESSOR_ADD(scan)
    % add regressors (not convolved with the basis functions)
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.design,   return; end
    if isempty(scan.job.regressor), return; end
    
    % print
    fprintf('Add regressors : \n');
    
    % regressor
    for i_regressor = 1:length(scan.job.regressor)
    
        switch scan.job.regressor(i_regressor).type
            case 'mask'
                % type mask
                mask = scan_nifti_load(fullfile(scan.directory.mask,scan.job.regressor(i_regressor).file));
                func_wait(sum(scan.running.subject.session));
                for i_subject = 1:scan.running.subject.number
                    for i_session = 1:scan.running.subject.session(i_subject)
                        vols = scan_nifti_load(scan.running.file.nii.epi3.(scan.job.image){i_subject}{i_session},mask);
                        vols = cellfun(@nanmean,vols);
                        scan.running.regressor{i_subject}{i_session}.name{end+1}        = scan.job.regressor(i_regressor).name;
                        scan.running.regressor{i_subject}{i_session}.regressor(:,end+1) = vols;
                        scan.running.regressor{i_subject}{i_session}.filter(end+1)      = scan.job.regressor(i_regressor).filter;
                        func_wait();
                    end
                end
                func_wait(0);
            
            case 'mat',
                % type mat-file
                func_wait(0);
                error('todo');
                
            case 'csv',
                % type csv-file
                func_wait(0);
                error('todo');
        end
    end
    
    % save scan
    scan_job_save_scan(scan);
end
