
function scan = scan_function_glm_folder_saveregressor(scan)
    %% scan = SCAN_FUNCTION_GLM_FOLDER_SAVEREGRESSOR(scan)
    % define function @folder.saveRegressor
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    if ~scan.running.flag.design,   return; end
    scan.function.folder.saveRegressor = @auxiliar_saveRegressor;

    %% nested
    function auxiliar_saveRegressor(varargin)
        if nargin~=2 || strcmp(varargin{1},'help')
            scan_tool_help(scan,'@saveRegressor(name,file)','This function saves a regressor specified in [scan.job.regressor] and loaded into [scan.running.regressor]. [name] is the name of the regressor. [file] is the path to the saved file, relative to [scan.directory.regressor]. Once the regressor is saved, it can be loaded directly using scan.job.regressor.type = ''mat''.');
            return;
        end
        
        % default
        [name,file] = varargin{1:2};
        
        % load
        if file_match(fullfile(scan.directory.regressor,file))
            regressor = file_loadvar(fullfile(scan.directory.regressor,file),'regressor');
        else
            regressor = cell(1,length(scan.parameter.path.subject));
        end
        
        % regressor
        for i_subject = 1:scan.running.subject.number
            subject = scan.running.subject.unique(i_subject);
            % load regressor
            for i_session = 1:scan.running.subject.session(i_subject)
                i_regressor = strcmp(scan.running.regressor{i_subject}{i_session}.name,name);
                regressor{subject}{i_session} = scan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor);
            end
        end
        
        % concatenation
        if isfield(scan.job,'concatSessions') && scan.job.concatSessions
            scam = scan;
            scam.running.subject.session = scam.subject.session(scam.running.subject.unique);
            scam = scan_autocomplete_nii(scam,['epi3:',scam.job.image]);
            for i_subject = 1:scam.running.subject.number
                subject = scam.running.subject.unique(i_subject);
                n_scans = cellfun(@length,scam.running.file.nii.epi3.(scam.job.image){i_subject});
                regressor{subject} = mat2cell(regressor{subject}{1},n_scans,1)';
            end
        end
        
        % save
        file_mkdir(scan.directory.regressor);
        save(fullfile(scan.directory.regressor,file),'regressor');
    end
end
