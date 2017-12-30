
function scan = scan_function_rsa_get_avgModel(scan)
    %% scan = SCAN_FUNCTION_RSA_GET_AVGMODEL(scan)
    % define function @get.avgModel
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.get.avgModel = @auxiliar_avgModel;

end

%% auxiliar
function varargout = auxiliar_avgModel(varargin)
    varargout = {};
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=2 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@model(scan,i_model)','This function gets the averaged model across participants.');
        return;
    end

    % default
    [i_model] = varargin{2};
    
    % get all RDMs
    avgModels = tcan.function.get.allModel(tcan,i_model);
    for i_subject = 1:tcan.running.subject.number
        avgModels{i_subject} = nanmean(cat(3,avgModels{i_subject}{:}),3);
    end
    avgModels = nanmean(cat(3,avgModels{:}),3);
    
    % return
    varargout = {avgModels};
end
