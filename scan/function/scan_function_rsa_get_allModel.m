
function scan = scan_function_rsa_get_allModel(scan)
    %% scan = SCAN_FUNCTION_RSA_GET_ALLMODEL(scan)
    % define function @get.allModel
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.get.allModel = @auxiliar_allModel;

end

%% auxiliar
function varargout = auxiliar_allModel(varargin)
    varargout = cell(1,nargout);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=2 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'allModel = @model(scan,i_model)','This function gets a model for all subjects.');
        return;
    end

    % default
    i_model = varargin{2};
    
    % get all model
    allModel = {};
    for i_subject = 1:tcan.running.subject.number
        [u_session,n_session] = numbers(tcan.running.subject.session{i_subject});
        for i_session = 1:n_session
            allModel{i_subject}{i_session} = tcan.function.get.model(tcan,i_subject,u_session(i_session),i_model); %#ok<AGROW>
        end
    end
    
    % return
    varargout = {allModel};
end