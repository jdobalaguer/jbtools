
function scan = scan_function_rsa_get_rdmModel(scan)
    %% scan = SCAN_FUNCTION_RSA_GET_RDMMODEL(scan)
    % define function @get.rdmModel
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.get.rdmModel = @auxiliar_rdmModel;

end

%% auxiliar
function varargout = auxiliar_rdmModel(varargin)
    varargout = {};
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=5 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@model(scan,i_subject,i_session,i_model,mask)','This function gets the RDM for a certain subject and session, within a certain mask, and filtered like a certain model would be.');
        return;
    end

    % default
    [i_subject,i_session,i_model,mask] = varargin{2:5};
    
    % get RDM
    rdm   = tcan.function.get.rdm  (tcan,i_subject,i_session,mask);
    model = tcan.function.get.model(tcan,i_subject,i_session,i_model);
    rdm(isnan(model)) = nan;
    varargout = {rdm};
end