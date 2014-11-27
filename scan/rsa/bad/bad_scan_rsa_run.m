
function scan = scan_rsa_run(scan)
    %% scan = SCAN_MVPA_RSA(scan)
    % runs a multi-voxel pattern analysis (MVPA)
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_glm
    %          scan_rsa_searchlight
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % SPM and rsa-toolbox
    if ~exist('spm.m',          'file'), spm8_add_paths(); end
    if ~exist('constructRDMs.m','file'), rsa_add_paths();  end
    
    % initialize
    opt.analysisName    = scan.rsa.name;
    opt.rootPath        = scan.dire.rsa.root;
    opt.subjectNames    = strcat('subject_',num2leg(scan.subject.u,'%02i'));
    opt.conditionLabels = scan.rsa.regressor;
    opt.maskPath        = scan.dire.mask;
    opt.maskNames       = {scan.rsa.mask};
    opt.distance        = 'Correlation';
    opt.RoIColor        = [0,0,0];
    opt.ModelColor      = [0,0,0];
    
    % set beta files
    beta = scan_rsa_beta(scan);

    % data preparation
%     fullBrainVols       = fMRIDataPreparation(beta,opt);
%     binaryMasks_nS      = fMRIMaskPreparation(opt);
%     responsePatterns    = fMRIDataMasking(fullBrainVols, binaryMasks_nS,beta,opt);
    
    % RDM calculation
%     RDMs                = constructRDMs(responsePatterns,beta,opt);
%     sRDMs               = averageRDMs_subjectSession(RDMs,'session');
%     RDMs                = averageRDMs_subjectSession(RDMs,'session', 'subject');
%     Models              = constructModelRDMs(modelRDMs(),opt);
    
    % first-order visualisation
%     figureRDMs(RDMs, userOptions, struct('fileName', 'RoIRDMs', 'figureNumber', 1));
%     figureRDMs(Models, userOptions, struct('fileName', 'ModelRDMs', 'figureNumber', 2));
%     MDSConditions(RDMs, userOptions);
%     dendrogramConditions(RDMs, userOptions);
    % Relationship amongst multiple RDMs
%     pairwiseCorrelateRDMs({RDMs, Models}, userOptions);
%     MDSRDMs({RDMs, Models}, userOptions);
    % Statistical inference
%     roiIndex = 1;% index of the ROI for which the group average RDM will serve as the reference RDM.
%     for i=1:numel(Models), models{i}=Models(i); end
%     userOptions.RDMcorrelationType='Kendall_taua';
%     userOptions.RDMrelatednessTest = 'subjectRFXsignedRank';
%     userOptions.RDMrelatednessThreshold = 0.05;
%     userOptions.figureIndex = [10 11];
%     userOptions.RDMrelatednessMultipleTesting = 'FDR';
%     userOptions.candRDMdifferencesTest = 'subjectRFXsignedRank';
%     userOptions.candRDMdifferencesThreshold = 0.05;
%     userOptions.candRDMdifferencesMultipleTesting = 'none';
%     stats_p_r=compareRefRDM2candRDMs(RDMs(roiIndex), models, userOptions);

end



%     userOptions.distanceMeasure = 'Spearman';
%     userOptions.saveFigurePDF   = true;
%     userOptions.saveFigurePS    = true;
%     userOptions.saveFigureFig   = false;
%     userOptions.saveFiguresJpg  = false;
%     userOptions.displayFigures  = true;
%     userOptions.imagelables     = {};
