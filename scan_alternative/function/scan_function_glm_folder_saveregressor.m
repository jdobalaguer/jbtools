
function scan = scan_function_glm_folder_saveregressor(scan)
    %% scan = SCAN_FUNCTION_GLM_FOLDER_SAVEREGRESSOR(scan)
    % define function @folder.saveRegressor
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    if ~scan.running.flag.design,   return; end
    scan.function.folder.saveRegressor = @auxiliar_saveRegressor;
end

%% auxiliar
function auxiliar_saveRegressor(varargin)
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=3 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@saveRegressor(scan,name,file)','This function saves a regressor specified in [scan.job.regressor] and loaded into [scan.running.regressor]. [name] is the name of the regressor. [file] is the path to the saved file, relative to [scan.directory.regressor]. Once the regressor is saved, it can be loaded directly using scan.job.regressor.type = ''mat''.');
        return;
    end

    % default
    [name,file] = varargin{2:3};

    % load
    if file_match(fullfile(tcan.directory.regressor,file))
        regressor = file_loadvar(fullfile(tcan.directory.regressor,file),'regressor');
    else
        regressor = cell(1,length(tcan.parameter.path.subject));
    end

    % regressor
    for i_subject = 1:tcan.running.subject.number
        subject = tcan.running.subject.unique(i_subject);
        % load regressor
        for i_session = 1:tcan.running.subject.session(i_subject)
            i_regressor = strcmp(tcan.running.regressor{i_subject}{i_session}.name,name);
            regressor{subject}{i_session} = tcan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor);
        end
    end

    % concatenation
    if isfield(tcan.job,'concatSessions') && tcan.job.concatSessions
        scam = tcan;
        scam.running.subject.session = scam.subject.session(scam.running.subject.unique);
        scam = scan_autocomplete_nii(scam,['epi3:',scam.job.image]);
        for i_subject = 1:scam.running.subject.number
            subject = scam.running.subject.unique(i_subject);
            n_scans = cellfun(@length,scam.running.file.nii.epi3.(scam.job.image){i_subject});
            regressor{subject} = mat2cell(regressor{subject}{1},n_scans,1)';
        end
    end

    % save
    file_mkdir(tcan.directory.regressor);
    save(fullfile(tcan.directory.regressor,file),'regressor');
end
