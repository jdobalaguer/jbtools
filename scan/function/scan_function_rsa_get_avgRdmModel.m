
function scan = scan_function_rsa_get_avgRdmModel(scan)
    %% scan = SCAN_FUNCTION_RSA_GET_AVGRDMMODEL(scan)
    % define function @get.avgRdmModel
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.get.avgRdmModel = @auxiliar_avgRdmModel;

end

%% auxiliar
function varargout = auxiliar_avgRdmModel(varargin)
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
    avgRDMs = tcan.function.get.allRdmModel(tcan,i_model,mask);
    for i_subject = 1:tcan.running.subject.number
        avgRDMs{i_subject} = nanmean(cat(3,avgRDMs{i_subject}{:}),3);
    end
    avgRDMs = nanmean(cat(3,avgRDMs{:}),3);
    
    % return
    varargout = {avgRDMs};
end
