
function scan = scan_preprocess_coregistration(scan)
    %% scan = SCAN_PREPROCESS_COREGISTRATION(scan)
    % coregister structural with the mean EPI
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.coregistration, return; end
        
    % print
    scan_tool_print(scan,false,'\nCoregistration (structural to functional) : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % variables
        file_origin         = scan.running.file.nii.structural.(scan.running.last.structural){i_subject};
        file_coregistration = fullfile(scan.running.directory.nii.structural.coregistration{i_subject},strcat('c',file_2local(file_origin)));
        file_mean           = file_match(fullfile(scan.running.directory.nii.epi3.(scan.running.last.epi3){i_subject}{1},'mean*.nii'),'absolute');
        
        % copy original file
        copyfile(file_origin,file_coregistration);
        
        % coregistration
        spm{i_subject}.spm.spatial.coreg.estimate.ref    = {[file_mean,',1']};
        spm{i_subject}.spm.spatial.coreg.estimate.source = {[file_coregistration,',1']};
        spm{i_subject}.spm.spatial.coreg.estimate.other  = {''};
        spm{i_subject}.spm.spatial.coreg.estimate.eoptions.cost_fun = spm_get_defaults('coreg.estimate.cost_fun');
        spm{i_subject}.spm.spatial.coreg.estimate.eoptions.sep      = spm_get_defaults('coreg.estimate.sep');
        spm{i_subject}.spm.spatial.coreg.estimate.eoptions.tol      = spm_get_defaults('coreg.estimate.tol');
        spm{i_subject}.spm.spatial.coreg.estimate.eoptions.fwhm     = spm_get_defaults('coreg.estimate.fwhm');
        
        % SPM
        evalc('spm_jobman(''run'',spm(i_subject))');
        
        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.coregistration = spm;
    
    % update
    scan = scan_autocomplete_nii(scan,'structural:coregistration');
    scan.running.last.structural = 'coregistration';
    
    % done
    scan = scan_tool_done(scan);
end
