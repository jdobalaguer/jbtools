
function scan = scan_preprocess_smooth(scan)
    %% scan = SCAN_PREPROCESS_SMOOTH(scan)
    % smoothing
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.smooth, return; end
    
    % print
    scan_tool_print(scan,false,'\nSmoothing : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % copy original files
        file_original = cell(1,scan.running.subject.session(i_subject));
        file_smooth   = cell(1,scan.running.subject.session(i_subject));
        for i_session = 1:scan.running.subject.session(i_subject)
            file_original{i_session} = file_list(fullfile(scan.running.directory.nii.epi3.(scan.running.last.epi3){i_subject}{i_session},'*.nii'),'absolute');
            file_smooth{i_session}   = strcat(scan.running.directory.nii.epi3.smooth{i_subject}{i_session},file_2local(file_original{i_session}));
            cellfun(@copyfile,file_original{i_session},file_smooth{i_session});
        end

        % smooth
        spm{i_subject}.spm.spatial.smooth.data = cat(1,file_smooth{:});

        % SPM
        evalc('spm_jobman(''run'',spm(i_subject))');

        % delete original file
        for i_session = 1:scan.running.subject.session(i_subject)
            cellfun(@delete,file_smooth{i_session});
        end
        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.smooth = spm;
    
    % update
    scan = scan_autocomplete_nii(scan,'epi3:smooth');
    scan.running.last.epi3 = 'smooth';
    
    % done
    scan = scan_tool_done(scan);
end
