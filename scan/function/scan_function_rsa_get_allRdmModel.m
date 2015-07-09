
function scan = scan_function_rsa_get_allRdmModel(scan)
    %% scan = SCAN_FUNCTION_RSA_GET_ALLRDMMODEL(scan)
    % define function @get.allRdmModel
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.get.allRdmModel = @auxiliar_allRdmModel;

end

%% auxiliar
function varargout = auxiliar_allRdmModel(varargin)
    varargout = {};
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=3 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@model(scan,i_model,mask)','This function get all the RDM within a mask, and filtered like a certain model would be.');
        return;
    end

    % default
    [i_model,mask] = varargin{2:3};
    
    % get all RDMs
    allRDMs = {};
    for i_subject = 1:tcan.running.subject.number
        for i_session = 1:tcan.running.subject.session(i_subject)
            allRDMs{i_subject}{i_session} = tcan.function.get.rdmModel(tcan,i_subject,i_session,i_model,mask); %#ok<AGROW>
        end
    end
    
    % return
    varargout = {allRDMs};
end