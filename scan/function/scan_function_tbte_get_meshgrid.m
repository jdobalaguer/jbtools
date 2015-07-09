
function scan = scan_function_tbte_get_meshgrid(scan)
    %% scan = SCAN_FUNCTION_TBTE_GET_MESHGRID(scan)
    % define the function @get.meshgrid
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.function,   return; end
    scan.function.get.meshgrid = @auxiliar_meshgrid;
end

%% auxiliar
function varargout = auxiliar_meshgrid(varargin)
    varargout = cell(1,nargin);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin<3 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'mesh = @meshgrid(scan,name,mask[,v1][,v2][,v3][,..])','This function loads the estimated betas within the region of interest [mask] for a particular regressor [name]. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. [v#] are vectors with integers that specifies how the data should be splitted (i.e. categorical regressors). the returning value [mesh] is a tensor of size [nsubject,nsession,nv1,nv2,..] with the average beta within the ROI for each combination.');
        return;
    end

    % default
    [name,mask] = varargin{2:3};
    vector = cellfun(@mat2vec,varargin(4:end),'UniformOutput',false);

    % assert
    if ~ischar(mask), auxiliar_meshgrid(tcan,'help'); return; end
    if ~ischar(name), auxiliar_meshgrid(tcan,'help'); return; end

    % get values
    beta    = tcan.function.get.beta(tcan,name,mask);
    subject = tcan.function.get.vector(tcan,name,'subject');
    session = tcan.function.get.vector(tcan,name,'session');

    % assert
    assertSize(beta(:,1),subject,session,vector{:});

    % get matrix
    mesh = cellfun(@mean,getm_all(nanmean(beta,2),subject,session,vector{:}));

    % return
    varargout = {mesh};
end
