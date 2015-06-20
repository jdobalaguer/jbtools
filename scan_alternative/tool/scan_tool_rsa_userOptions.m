
function userOptions = scan_tool_rsa_userOptions(scan,i_subject)
    %% userOptions = SCAN_TOOL_RSA_USEROPTIONS(scan,i_subject)
    % RSA toolbox - create userOptions
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    userOptions.analysisName = scan.job.name;
    userOptions.rootPath = scan.running.directory.job;
    userOptions.betaPath = fullfile(scan.running.glm.running.directory.copy.first.beta,'[[betaIdentifier]]');

    % FEATUERS OF INTEREST SELECTION OPTIONS
    userOptions.maskPath = fullfile(scan.running.glm.running.directory.original.first{i_subject},'[[maskName]].nii');
    userOptions.maskNames = {'mask'};

    % SEARCHLIGHT OPTIONS
    userOptions.structuralsPath = fullfile(scan.directory.nii,'[[subjectName]]/structural/normalisation/4/');
    userOptions.voxelSize = [3 3 3.75];
    userOptions.searchlightRadius = 15;

    % EXPERIMENTAL SETUP
    userOptions.subjectNames = scan.parameter.path.subject(i_subject);
    userOptions.RoIColor = [0 0 1];
    userOptions.ModelColor = [0 1 0];
    userOptions.getSPMData = false;

    % ANALYSIS PREFERENCES
    [u_condition,n_condition] = numbers(scan.running.load.name);
    userOptions.conditionLabels  = strcat(scan.running.load.name,scan.running.load.version);
    userOptions.conditionColours = cell2mat(cell_replace(scan.running.load.name,u_condition,mat2cell(fig_color('parula',n_condition),ones(1,n_condition),3)));
    userOptions.distance = scan.job.distance;
    userOptions.distanceMeasure = scan.job.comparison;
    userOptions.significanceTestPermutations = 10000;
    userOptions.nResamplings = 1000;
    userOptions.resampleSubjects = true;
    userOptions.resampleConditions = false;
    userOptions.rankTransform = true;
    userOptions.rubberbands = true;
    userOptions.criterion = 'metricstress';
    userOptions.colourScheme = bone(128);
    userOptions.displayFigures = true;
    userOptions.saveFiguresPDF = true;
    userOptions.saveFiguresFig = false;
    userOptions.saveFiguresPS = false;
    userOptions.dpi = 300;
    userOptions.tightInset = false;
    userOptions.forcePromptReply = 'r';
end
