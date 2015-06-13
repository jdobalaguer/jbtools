
function scan = scan_preprocess_estimation(scan)
    %% scan = SCAN_PREPROCESS_ESTIMATION(scan)
    % estimate normalisation parameters, from coregistered structural to MNI space
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.estimation, return; end
    
    % print
    scan_tool_print(scan,false,'\nNormalisation (coregistered structural to MNI) : ');
    scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % variables
        file_origin        = scan.running.file.nii.structural.(scan.running.last.structural){i_subject};
        file_normalisation = fullfile(scan.running.directory.nii.structural.normalisation{i_subject},file_2local(file_origin));
        
        % copy original file
        copyfile(file_origin,file_normalisation);
        
        % normalisation
        spm{i_subject}.spm.spatial.normalise.estwrite.subj.vol          = {[file_normalisation,',1']};
        spm{i_subject}.spm.spatial.normalise.estwrite.subj.resample     = {[file_normalisation,',1']};
        spm{i_subject}.spm.spatial.normalise.estwrite.eoptions.biasreg  = spm_get_defaults('old.preproc.biasreg');
        spm{i_subject}.spm.spatial.normalise.estwrite.eoptions.biasfwhm = spm_get_defaults('old.preproc.biasreg');
        spm{i_subject}.spm.spatial.normalise.estwrite.eoptions.tpm      = {scan.file.template.tpm};
        spm{i_subject}.spm.spatial.normalise.estwrite.eoptions.affreg   = spm_get_defaults('old.preproc.regtype');
        spm{i_subject}.spm.spatial.normalise.estwrite.eoptions.reg      = [0,0.001,0.5,0.05,0.2];
        spm{i_subject}.spm.spatial.normalise.estwrite.eoptions.fwhm     = 0;
        spm{i_subject}.spm.spatial.normalise.estwrite.eoptions.samp     = spm_get_defaults('old.preproc.samp');
        spm{i_subject}.spm.spatial.normalise.estwrite.woptions.bb       = spm_get_defaults('normalise.write.bb');
        spm{i_subject}.spm.spatial.normalise.estwrite.woptions.vox      = repmat(scan.parameter.analysis.voxs,[1,3]);
        spm{i_subject}.spm.spatial.normalise.estwrite.woptions.interp   = spm_get_defaults('normalise.write.interp');
        
        % SPM
        T = evalc('spm_jobman(''run'',spm(i_subject))')
        
        % delete original file
        delete(file_normalisation);
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.normalisation = spm;
    
    % update
    scan = scan_autocomplete_nii(scan,'structural:coregistration');
    scan.running.last.structural = 'coregistration';
end
