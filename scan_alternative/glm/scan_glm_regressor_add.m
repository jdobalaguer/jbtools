
function scan = scan_glm_regressor_add(scan)
    %% scan = SCAN_GLM_REGRESSOR_ADD(scan)
    % add regressors (not convolved with the basis functions)
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.design,   return; end
    if ~scan.job.realignCovariate && isempty(scan.job.regressor), return; end
    
    % print
    scan_tool_print(scan,false,'\nAdd regressor : ');
    
    % realignment
    if scan.job.realignCovariate
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                scan.running.regressor{i_subject}{i_session}.name(end+1:end+6)        = num2leg(1:6,'realignment %03i');
                scan.running.regressor{i_subject}{i_session}.regressor(:,end+1:end+6) = load(file_match([scan.running.directory.nii.epi3.realignment{i_subject}{i_session},'*.txt'],'absolute'));
                scan.running.regressor{i_subject}{i_session}.filter(end+1:end+6)      = false(1,6);
                scan.running.regressor{i_subject}{i_session}.zscore(end+1:end+6)      = false(1,6);
                scan.running.regressor{i_subject}{i_session}.covariate(end+1:end+6)   = true (1,6);
                scan_tool_assert(scan,size(scan.running.regressor{i_subject}{i_session}.regressor,1) == length(scan.running.file.nii.epi3.(scan.job.image){i_subject}{i_session}), 'realignment file doesnt match number of files');
            end
        end
    end
    
    % regressor
    for i_regressor = 1:length(scan.job.regressor)
    
        switch scan.job.regressor(i_regressor).type
            case 'mask'
                % type mask
                mask = scan_nifti_load(fullfile(scan.directory.mask,scan.job.regressor(i_regressor).file));
                scan_tool_progress(scan,sum(scan.running.subject.session));
                for i_subject = 1:scan.running.subject.number
                    for i_session = 1:scan.running.subject.session(i_subject)
                        vols = scan_nifti_load(scan.running.file.nii.epi3.(scan.job.image){i_subject}{i_session},mask);
                        vols = cellfun(@nanmean,vols);
                        scan.running.regressor{i_subject}{i_session}.name{end+1}        = scan.job.regressor(i_regressor).name;
                        scan.running.regressor{i_subject}{i_session}.regressor(:,end+1) = vols;
                        scan.running.regressor{i_subject}{i_session}.filter(end+1)      = scan.job.regressor(i_regressor).filter;
                        scan.running.regressor{i_subject}{i_session}.zscore(end+1)      = scan.job.regressor(i_regressor).zscore;
                        scan.running.regressor{i_subject}{i_session}.covariate(end+1)   = scan.job.regressor(i_regressor).covariate;
                        scan_tool_progress(scan,[]);
                    end
                end
                scan_tool_progress(scan,0);
            
            case 'mat',
                % type mat-file
                regressor = file_loadvar(fullfile(scan.directory.regressor,scan.job.regressor(i_regressor).file),'regressor');
                scan_tool_progress(scan,sum(scan.running.subject.session));
                for i_subject = 1:scan.running.subject.number
                    subject = scan.running.subject.unique(i_subject);
                    scan_tool_assert(scan,~isempty(regressor{subject}),                                        'regressor "%s" is empty for subject "%03i"',scan.job.regressor(i_regressor).file,subject);
                    scan_tool_assert(scan,length(regressor{subject})==scan.running.subject.session(i_subject), 'regressor "%s" has wrong number of sessions for subject "%s"',scan.job.regressor(i_regressor).file,subject);
                    for i_session = 1:scan.running.subject.session(i_subject)
                        scan.running.regressor{i_subject}{i_session}.name{end+1}        = scan.job.regressor(i_regressor).name;
                        scan.running.regressor{i_subject}{i_session}.regressor(:,end+1) = regressor{subject}{i_session};
                        scan.running.regressor{i_subject}{i_session}.filter(end+1)      = scan.job.regressor(i_regressor).filter;
                        scan.running.regressor{i_subject}{i_session}.zscore(end+1)      = scan.job.regressor(i_regressor).zscore;
                        scan.running.regressor{i_subject}{i_session}.covariate(end+1)   = scan.job.regressor(i_regressor).covariate;
                        scan_tool_progress(scan,[]);
                    end
                end
                scan_tool_progress(scan,0);
        end
    end
    
    % done
    scan = scan_tool_done(scan);
end
