
function scan = scan_preprocess_estimation(scan)
    %% scan = SCAN_PREPROCESS_ESTIMATION(scan)
    % apply normalisation, from coregistered structural to MNI space
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.estimation, return; end
    
    % print
    scan_tool_print(scan,false,'\nNormalisation (structural to MNI) : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % variables
        file_origin      = scan.running.file.nii.structural.(scan.running.last.structural).m{i_subject};
        file_estimation  = fullfile(scan.running.directory.nii.structural.normalisation{i_subject},strcat(file_2local(file_origin)));

        % copy original file
        copyfile(file_origin,file_estimation);
        
        % normalisation
        spm{i_subject}.spm.spatial.normalise.write.subj.def      = {scan.running.file.nii.structural.(scan.running.last.structural).y{i_subject}}; %#ok<CCAT1>
        spm{i_subject}.spm.spatial.normalise.write.subj.resample = {file_estimation};
        spm{i_subject}.spm.spatial.normalise.write.woptions.vox  = repmat(scan.parameter.analysis.voxs,[1,3]);

        % SPM
        evalc('spm_jobman(''run'',spm(i_subject))');

        % delete original file
        delete(file_estimation);
        
        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.estimation = spm;
    
    % update
    scan = scan_autocomplete_nii(scan,'structural:normalisation');
    % dont update [scan.running.last.structural], otherwise normalisation will fail
    
    % done
    scan = scan_tool_done(scan);
end
