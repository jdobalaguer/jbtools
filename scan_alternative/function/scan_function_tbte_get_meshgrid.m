
function scan = scan_function_tbte_get_meshgrid(scan)
    %% scan = SCAN_FUNCTION_TBTE_GET_MESHGRID(scan)
    % define the function @get.meshgrid
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.function,   return; end
    scan.function.get.meshgrid = @auxiliar_meshgrid;
    
    %% nested
    function varargout = auxiliar_meshgrid(varargin)
        varargout = cell(1,nargout);
        if nargin<2 || strcmp(varargin{1},'help')
            scan_tool_help('mesh = @meshgrid(name,mask[,v1][,v2][,v3][,..])','This function loads the estimated betas within the region of interest [mask] for a particular regressor [name]. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. [v#] are vectors with integers that specifies how the data should be splitted (i.e. categorical regressors). the returning value [mesh] is a tensor of size [nsubject,nsession,nv1,nv2,..] with the average beta within the ROI for each combination.');
            return;
        end
        
        % default
        [name,mask] = deal(varargin{1:2});
        vector = cellfun(@mat2vec,varargin(3:end),'UniformOutput',false);
        
        % assert
        if ~ischar(mask), auxiliar_meshgrid('help'); return; end
        if ~ischar(name), auxiliar_meshgrid('help'); return; end
        
        % get values
        beta    = scan.function.get.beta(name,mask);
        subject = scan.function.get.vector(name,'subject');
        session = scan.function.get.vector(name,'session');
        
        % assert
        assertSize(beta(:,1),subject,session,vector{:});
        
        % get matrix
        mesh = cellfun(@mean,getm_all(nanmean(beta,2),subject,session,vector{:}));
        
        % return
        varargout = {mesh};
    end
end
