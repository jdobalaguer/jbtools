
function scan = scan_function_glm_get_beta(scan)
    %% scan = SCAN_FUNCTION_GLM_GET_BETA(scan)
    % define function @get.beta
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function,   return; end
    if ~scan.running.flag.estimation, return; end
    scan.function.get.beta = @auxiliar_beta;

    %% nested
    function varargout = auxiliar_beta(varargin)
        if nargin~=2 || strcmp(varargin{1},'help')
            varargout = {};
            scan_tool_help(scan,'beta = @get.beta(name,mask)','This function loads the estimated beta values within a region of interest [mask] and for a condition [name]. [name] is the name of the condition. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. the resulting variable [beta] is a vector with all betas. to index this vector properly, see @scan.function.get.vector');
            return;
        end
        
        % default
        [name,mask] = deal(varargin{1:2});
        
        % assert
        if ~ischar(name), auxiliar_beta('help'); return; end
        if ~ischar(mask), auxiliar_beta('help'); return; end
        
        % mask
        if ~isempty(mask), mask = scan_nifti_load(fullfile(scan.directory.mask,mask));
        else               mask = [];
        end
        
        % variables
        version = scan.function.get.vector(name,'version');
        subject = scan.function.get.vector(name,'subject');
        session = scan.function.get.vector(name,'session');
        order   = scan.function.get.vector(name,'order');
        
        % files
        file = cellfun(@(s,r,o) sprintf('subject_%03i session_%03i order_%03i.nii',s,r,o),num2cell(mat2vec(scan.running.subject.unique(subject))),num2cell(session),num2cell(order),'UniformOutput',false);
        file = fullfile(scan.running.directory.copy.first.beta,strcat(name,version),file);
        
        % beta
        beta = scan_nifti_load(file,mask);
        beta = cell2mat(beta')';
        
        % return
        varargout = {beta};
    end
end
