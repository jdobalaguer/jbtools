
function scan = scan_function_glm_get_beta(scan)
    %% scan = SCAN_FUNCTION_GLM_GET_BETA(scan)
    % define function @get.beta
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function,   return; end
    if ~scan.running.flag.estimation, return; end
    scan.function.get.beta = @auxiliar_beta;
end

%% auxiliar
function varargout = auxiliar_beta(varargin)
    varargout = cell(1,nargin);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=3 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'beta = @get.beta(scan,name,mask)','This function loads the estimated beta values within a region of interest [mask] and for a condition [name]. [name] is the name of the condition. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. the resulting variable [beta] is a vector with all betas. to index this vector properly, see @scan.function.get.vector');
        return;
    end

    % default
    [name,mask] = varargin{2:3};

    % assert
    if ~ischar(name), auxiliar_beta(tcan,'help'); return; end
    if ~ischar(mask), auxiliar_beta(tcan,'help'); return; end

    % mask
    if ~isempty(mask), mask = scan_nifti_load(fullfile(tcan.directory.mask,mask));
    else               mask = [];
    end

    % variables
    version = tcan.function.get.vector(tcan,name,'version');
    subject = tcan.function.get.vector(tcan,name,'subject');
    session = tcan.function.get.vector(tcan,name,'session');
    order   = tcan.function.get.vector(tcan,name,'order');

    % files
    file = cellfun(@(s,r,o) sprintf('subject_%03i session_%03i order_%03i.nii',s,r,o),num2cell(mat2vec(tcan.running.subject.unique(subject))),num2cell(session),num2cell(order),'UniformOutput',false);
    file = fullfile(tcan.running.directory.copy.first.beta,strcat(name,version),file);

    % beta
    beta = scan_nifti_load(file,mask);
    beta = cell2mat(beta')';

    % return
    varargout = {beta};
end
