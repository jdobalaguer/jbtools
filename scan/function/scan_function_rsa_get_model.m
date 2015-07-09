
function scan = scan_function_rsa_get_model(scan)
    %% scan = SCAN_FUNCTION_RSA_GET_MODEL(scan)
    % define function @get.model
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.get.model = @auxiliar_model;

end

%% auxiliar
function varargout = auxiliar_model(varargin)
    varargout = {};
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=4 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@model(scan,i_subject,i_session,i_model)','This function gets the model RDM.');
        return;
    end

    % default
    [i_subject,i_session,i_model] = varargin{2:4};
    
    % get RDM
    rdm = tcan.running.model(i_model).rdm{i_subject}{i_session}.rdm;
    
    % retugn
    varargout = {rdm};
end
