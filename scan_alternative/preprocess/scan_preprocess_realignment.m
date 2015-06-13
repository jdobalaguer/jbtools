
function scan = scan_preprocess_realignment(scan)
    %% scan = SCAN_PREPROCESS_REALIGNMENT(scan)
    % realign & unwarp EPI images
    % to list main functions, try
    %   >> help scan;

    %% note
    % the unwarp method is explained here
    %   "http://www.fil.ion.ucl.ac.uk/spm/toolbox/unwarp/"
    
    %% function
    if ~scan.running.flag.realignment, return; end
    
    % print
    scan_tool_print(scan,false,'\nRealignment : ');
    scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % copy original files
        for i_session = 1:scan.running.subject.session(i_subject)
            copyfile(fullfile(scan.running.directory.nii.epi3.(scan.running.last.epi3){i_subject}{i_session},'*.nii'),scan.running.directory.nii.epi3.realignment{i_subject}{i_session});
        end
        
        switch scan.job.unwarp
        
            % estimate and reslice
            case 'no'
                spm{i_subject}.spm.spatial.realign.estwrite.eoptions.quality    = spm_get_defaults('realign.estimate.quality'); % Quality (Default: 0.9)
                spm{i_subject}.spm.spatial.realign.estwrite.eoptions.sep        = spm_get_defaults('realign.estimate.sep');     % Separation (Default: 4) 
                spm{i_subject}.spm.spatial.realign.estwrite.eoptions.fwhm       = spm_get_defaults('realign.estimate.fwhm');    % Smoothing (FWHM) (Default: 5)
                spm{i_subject}.spm.spatial.realign.estwrite.eoptions.rtm        = spm_get_defaults('realign.estimate.rtm');     % Num Passes (Default: Register to mean) 
                spm{i_subject}.spm.spatial.realign.estwrite.eoptions.interp     = spm_get_defaults('realign.estimate.interp');  % Interpolation (Default: 2nd Degree B-Spline)
                spm{i_subject}.spm.spatial.realign.estwrite.eoptions.wrap       = spm_get_defaults('realign.estimate.wrap');    % Wrapping (Default: No wrap) 
                spm{i_subject}.spm.spatial.realign.estwrite.eoptions.weight     = '' ;                                          % Weighting (Default: None)
                spm{i_subject}.spm.spatial.realign.estwrite.roptions.which      = spm_get_defaults('realign.write.which');      % Resliced Images ([0 1] > Only Mean Image; Default: [2 1] > All Images + Mean Image)
                spm{i_subject}.spm.spatial.realign.estwrite.roptions.interp     = spm_get_defaults('realign.write.interp');     % Interpolation (Default: 4th Degree B-Spline)
                spm{i_subject}.spm.spatial.realign.estwrite.roptions.wrap       = spm_get_defaults('realign.write.wrap');       % Wrapping (Default: No wrap) 
                spm{i_subject}.spm.spatial.realign.estwrite.roptions.mask       = spm_get_defaults('realign.write.mask');       % Masking (Default: Mask images)
                spm{i_subject}.spm.spatial.realign.estwrite.roptions.prefix     = spm_get_defaults('realign.write.prefix');     % Realigned files prefix
                for i_session = 1:scan.running.subject.session(i_subject)
                    spm{i_subject}.spm.spatial.realign.estwrite.data{i_session} = file_list(fullfile(scan.running.directory.nii.epi3.realignment{i_subject}{i_session},'*.nii'),'absolute');
                end
            
            % unwarp
            case 'unwarp'
                spm{i_subject}.spm.spatial.realignunwarp.eoptions.quality       = spm_get_defaults('realign.estimate.quality'); % Quality (Default: 0.9)
                spm{i_subject}.spm.spatial.realignunwarp.eoptions.sep           = spm_get_defaults('realign.estimate.sep');     % Separation (Default: 4) 
                spm{i_subject}.spm.spatial.realignunwarp.eoptions.fwhm          = spm_get_defaults('realign.estimate.fwhm');    % Smoothing (FWHM) (Default: 5)
                spm{i_subject}.spm.spatial.realignunwarp.eoptions.rtm           = spm_get_defaults('realign.estimate.rtm');     % Num Passes (Default: Register to mean) 
                spm{i_subject}.spm.spatial.realignunwarp.eoptions.einterp       = spm_get_defaults('realign.estimate.interp');  % Interpolation (Default: 2nd Degree B-Spline)
                spm{i_subject}.spm.spatial.realignunwarp.eoptions.ewrap         = spm_get_defaults('realign.estimate.wrap');    % Wrapping (Default: No wrap) 
                spm{i_subject}.spm.spatial.realignunwarp.eoptions.weight        = '' ;                                          % Weighting (Default: None)
                spm{i_subject}.spm.spatial.realignunwarp.uwroptions.uwwhich     = spm_get_defaults('realign.write.which');      % Resliced Images ([0 1] > Only Mean Image; Default: [2 1] > All Images + Mean Image)
                spm{i_subject}.spm.spatial.realignunwarp.uwroptions.rinterp     = spm_get_defaults('realign.write.interp');     % Interpolation (Default: 4th Degree B-Spline)
                spm{i_subject}.spm.spatial.realignunwarp.uwroptions.wrap        = spm_get_defaults('realign.write.wrap');       % Wrapping (Default: No wrap) 
                spm{i_subject}.spm.spatial.realignunwarp.uwroptions.mask        = spm_get_defaults('realign.write.mask');       % Masking (Default: Mask images)
                spm{i_subject}.spm.spatial.realignunwarp.uwroptions.prefix      = spm_get_defaults('unwarp.write.prefix');      % Realigned files prefix
                spm{i_subject}.spm.spatial.realignunwarp.uweoptions.basfcn      = spm_get_defaults('unwarp.estimate.basfcn');
                spm{i_subject}.spm.spatial.realignunwarp.uweoptions.regorder    = spm_get_defaults('unwarp.estimate.regorder');
                spm{i_subject}.spm.spatial.realignunwarp.uweoptions.lambda      = spm_get_defaults('unwarp.estimate.regwgt');
                spm{i_subject}.spm.spatial.realignunwarp.uweoptions.jm          = spm_get_defaults('unwarp.estimate.jm');
                spm{i_subject}.spm.spatial.realignunwarp.uweoptions.fot         = spm_get_defaults('unwarp.estimate.foe');
                spm{i_subject}.spm.spatial.realignunwarp.uweoptions.sot         = spm_get_defaults('unwarp.estimate.soe');
                spm{i_subject}.spm.spatial.realignunwarp.uweoptions.uwfwhm      = spm_get_defaults('unwarp.estimate.fwhm');
                spm{i_subject}.spm.spatial.realignunwarp.uweoptions.rem         = spm_get_defaults('unwarp.estimate.rem');
                spm{i_subject}.spm.spatial.realignunwarp.uweoptions.noi         = spm_get_defaults('unwarp.estimate.noi');
                spm{i_subject}.spm.spatial.realignunwarp.uweoptions.expround    = spm_get_defaults('unwarp.estimate.expround');
                for i_session = 1:scan.running.subject.session(i_subject)
                    spm{i_subject}.spm.spatial.realignunwarp.data(i_session).scans  = file_list(fullfile(scan.running.directory.nii.epi3.realignment{i_subject}{i_session},'*.nii'),'absolute');
                    spm{i_subject}.spm.spatial.realignunwarp.data(i_session).pmscan = [];
                end
                
            % unwarp with GRE fieldmaps
            case 'fieldmap'
                scan_tool_error(scan,'not implemented yet.');
        end
        
        
        % SPM
        evalc('spm_jobman(''run'',spm(i_subject))');
        
        % delete original files
        for i_session = 1:scan.running.subject.session(i_subject)
            path = scan.running.directory.nii.epi3.realignment{i_subject}{i_session};
            name = cellfun(@file_2local,scan.running.file.nii.epi3.(scan.running.last.epi3){i_subject}{i_session},'UniformOutput',false);
            file = fullfile(path,name);
            for i = 1:length(file), delete(file{i}); end
        end
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.realignment = spm;
    
    % update
    scan = scan_autocomplete_nii(scan,'epi3:realignment');
    scan.running.last.epi3 = 'realignment';
end
