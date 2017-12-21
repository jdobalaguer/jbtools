
function scan = scan_function_rsa_get_allRdm(scan)
    %% scan = SCAN_FUNCTION_RSA_GET_ALLRDM(scan)
    % define function @get.allRdm
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.get.allRdm = @auxiliar_allRdm;

end

%% auxiliar
function varargout = auxiliar_allRdm(varargin)
    varargout = cell(1,nargout);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=2 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'allRDMs = @model(scan,mask)','This function get all the RDM within a mask.');
        return;
    end

    % default
    mask = varargin{2};
    
    % get all RDMs
    allRDMs = {};
    for i_subject = 1:tcan.running.subject.number
        [u_session,n_session] = numbers(tcan.running.subject.session{i_subject});
        for i_session = 1:n_session
            allRDMs{i_subject}{i_session} = tcan.function.get.rdm(tcan,i_subject,u_session(i_session),mask); %#ok<AGROW>
        end
    end
    
    % return
    varargout = {allRDMs};
end