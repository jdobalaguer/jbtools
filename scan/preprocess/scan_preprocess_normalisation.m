
function scan = scan_preprocess_normalisation(scan)
    %% scan = SCAN_PREPROCESS_NORMALISATION(scan)
    % apply normalisation, from mean EPI to MNI space
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.normalisation, return; end
    
    % print
    scan_tool_print(scan,false,'\nNormalisation (functional to MNI) : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % copy original files
        file_original      = cell(1,scan.running.subject.session(i_subject));
        file_normalisation = cell(1,scan.running.subject.session(i_subject));
        for i_session = 1:scan.running.subject.session(i_subject)
            file_original{i_session}      = file_list(fullfile(scan.running.directory.nii.epi3.(scan.running.last.epi3){i_subject}{i_session},'*.nii'),'absolute');
            file_normalisation{i_session} = strcat(scan.running.directory.nii.epi3.normalisation{i_subject}{i_session},file_2local(file_original{i_session}));
            cellfun(@copyfile,file_original{i_session},file_normalisation{i_session});
        end

        % normalisation
        spm{i_subject}.spm.spatial.normalise.write.subj.def      = {scan.running.file.nii.structural.(scan.running.last.structural).y{i_subject}}; %#ok<CCAT1>
        spm{i_subject}.spm.spatial.normalise.write.subj.resample = cat(1,file_normalisation{:});
        spm{i_subject}.spm.spatial.normalise.write.woptions.vox  = repmat(scan.parameter.analysis.voxs,[1,3]);

        % SPM
        evalc('spm_jobman(''run'',spm(i_subject))');

        % delete original file
        for i_session = 1:scan.running.subject.session(i_subject)
            cellfun(@delete,file_normalisation{i_session});
        end
        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.normalisation = spm;
    
    % update
    scan = scan_autocomplete_nii(scan,'epi3:normalisation');
    scan.running.last.structural = 'normalisation';
    
    % done
    scan = scan_tool_done(scan);
end
