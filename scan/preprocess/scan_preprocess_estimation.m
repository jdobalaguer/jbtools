
function scan = scan_preprocess_estimation(scan)
    %% scan = SCAN_PREPROCESS_ESTIMATION(scan)
    % estimate normalisation parameters, from coregistered structural to MNI space
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
        file_origin        = scan.running.file.nii.structural.(scan.running.last.structural){i_subject};
        file_normalisation = fullfile(scan.running.directory.nii.structural.normalisation{i_subject},file_2local(file_origin));
        
        % copy original file
        copyfile(file_origin,file_normalisation);
        
        % normalisation
        spm{i_subject}.spm.spatial.normalise.est.subj.vol          = {[file_normalisation,',1']};
        spm{i_subject}.spm.spatial.normalise.est.eoptions.biasreg  = spm_get_defaults('old.preproc.biasreg');
        spm{i_subject}.spm.spatial.normalise.est.eoptions.biasfwhm = spm_get_defaults('old.preproc.biasfwhm');
        spm{i_subject}.spm.spatial.normalise.est.eoptions.tpm      = {[scan.file.template.t1,',1']}; %{scan.file.template.tpm};
        spm{i_subject}.spm.spatial.normalise.est.eoptions.affreg   = spm_get_defaults('old.preproc.regtype');
        spm{i_subject}.spm.spatial.normalise.est.eoptions.reg      = [0,0.001,0.5,0.05,0.2];
        spm{i_subject}.spm.spatial.normalise.est.eoptions.fwhm     = 0;
        spm{i_subject}.spm.spatial.normalise.est.eoptions.samp     = spm_get_defaults('old.preproc.samp');
        
        % SPM
%         evalc('spm_jobman(''run'',spm(i_subject))');
        spm_jobman('run',spm(i_subject));
        
        % delete original file
%         delete(file_normalisation);
        
        % delete y_ file
%         [p,n,e] = fileparts(file_normalisation);
%         delete([p,'y_',n,e]);
        
        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.normalisation = spm;
    
    % update
    scan = scan_autocomplete_nii(scan,'structural:normalisation');
    scan.running.last.structural = 'normalisation';
    
    % done
    scan = scan_tool_done(scan);
end
