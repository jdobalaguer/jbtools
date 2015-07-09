
function [scan,job] = scan_preprocess_normalisation_str(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_NORMALISATION_STR(scan,job)
    % preprocessing normalisation (structural to MNI space)
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<*AGROW>

    %% FUNCTION
    
    % assert
    assertWarning(all(job.run==1),'scan_preprocess_coregistration: warning. job.run set to 1');
    job.run(:) = 1;
    
    % normalisation
    batches = {};
    for i_subject = scan.subject.u
        fprintf('Normalisation (structural) : subject %02i \n',i_subject);
        dir_from = strcat(sprintf(job.from.path,i_subject),filesep);
        file_from = dir([dir_from,job.from.file]);
        assert(length(file_from)==1,'scan_preprocess_normalisation_str: error. multiple structural files');
        batch = struct();
        batch.spm.spatial.normalise.estwrite.subj.source = {[dir_from,file_from.name]};         % Image to estimate warping parameters: HIGHRES
        batch.spm.spatial.normalise.estwrite.subj.wtsrc = {};                                   % Source Weighting Image: None
        batch.spm.spatial.normalise.estwrite.subj.resample = {[dir_from,file_from.name]};       % Images to write according to warping parameters: HIGHRES 
        batch.spm.spatial.normalise.estwrite.eoptions.template = {scan.file.T1};                % Template Image
        batch.spm.spatial.normalise.estwrite.eoptions.weight = {};                              % Template Weighting Imaging, Default: None
        batch.spm.spatial.normalise.estwrite.eoptions.smosrc = 8;                               % Source Image Smoothing, Default: 8
        batch.spm.spatial.normalise.estwrite.eoptions.smoref = 0;                               % Template Image Smoothing, Default: 0
        batch.spm.spatial.normalise.estwrite.eoptions.regtype = 'mni';                          % Affine Regularisation, Default: ICBM/MNI Space Template
        batch.spm.spatial.normalise.estwrite.eoptions.cutoff = 25;                              % Nonlinear Frequency Cutoff, Default: 25
        batch.spm.spatial.normalise.estwrite.eoptions.nits = 16;                                % Nonlinear Iterations, Default: 16
        batch.spm.spatial.normalise.estwrite.eoptions.reg = 1;                                  % Nonlinear Regularisation, Default: 1
        batch.spm.spatial.normalise.estwrite.roptions.preserve = 0;                             % Default: 0 = Preserve Concentrations
        batch.spm.spatial.normalise.estwrite.roptions.bb = [-78 -112 -70;78 76 85];             % Bounding Box
        batch.spm.spatial.normalise.estwrite.roptions.vox = repmat(scan.pars.voxs,[1,3]);       % Voxel Sizes [2 2 2] is default
        batch.spm.spatial.normalise.estwrite.roptions.interp = 1;                               % Interpolation (Default: 1)
        batch.spm.spatial.normalise.estwrite.roptions.wrap = [0 0 0];                           % Wrapping, 0: No
        batch.spm.spatial.normalise.estwrite.roptions.prefix = 'w';                             % Prefix
        batches{end+1} = batch;
    end
    if ~isempty(batches)
        spm_jobman('run',batches);
    end
end
