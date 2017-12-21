
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
    if nargin~=6 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'beta = @get.beta(scan,i_subject,i_session,order,name,mask)','This function loads the estimated beta values within a region of interest [mask] and for a condition [name]. [name] is the name of the condition. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. the resulting variable [beta] is a vector with all betas. to index this vector properly, see @scan.function.get.vector');
        return;
    end

    % default
    [i_subject,i_session,order,name,mask] = varargin{2:6};

    % assert
    if ~ischar(name), auxiliar_beta(tcan,'help'); return; end
    if ~ischar(mask), auxiliar_beta(tcan,'help'); return; end

    % mask
    if ~isempty(mask), mask = scan_nifti_load(fullfile(tcan.directory.mask,mask));
    else               mask = [];
    end

    % variables
    u_version     = tcan.function.get.vector(tcan,i_subject,i_session,order,name,'version');
    u_subject     = tcan.function.get.vector(tcan,i_subject,i_session,order,name,'subject');
    u_session     = tcan.function.get.vector(tcan,i_subject,i_session,order,name,'session');
    u_order       = tcan.function.get.vector(tcan,i_subject,i_session,order,name,'order');
    u_covariate   = tcan.function.get.vector(tcan,i_subject,i_session,order,name,'covariate');

    % files
    file = cellfun(@(s,r,o) sprintf('subject_%03i session_%03i order_%03i.nii',s,r,o),num2cell(mat2vec(u_subject)),num2cell(u_session),num2cell(u_order),'UniformOutput',false);
    file = fullfile(tcan.running.directory.copy.first.beta,strcat(name,u_version),file);
    file(logical(u_covariate)) = [];

    % beta
    beta = scan_nifti_load(file,mask);
    beta = cell2mat(beta')';

    % return
    varargout = {beta};
end
