
function scan = scan_function_glm_get_vector(scan)
    %% scan = SCAN_FUNCTION_GLM_GET_VECTOR(scan)
    % define function @get.vector
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function,   return; end
    if ~scan.running.flag.estimation, return; end
    scan.function.get.vector = @auxiliar_vector;

    %% nested
    function varargout = auxiliar_vector(varargin)
        varargout = cell(1,nargout);
        if nargin~=2 || strcmp(varargin{1},'help')
            scan_tool_help('v = @get.vector(name,field)','This function loads or transform a vector so that it can index the vector of betas from @scan.function.get.beta. [name] is the name of a condition. [field] can be any of {''main'',''name'',''subject'',''session'',''version'',''order'',''covariate''}. [u] is a vector of same length than those in [scan.job.condition]. [v] is the the resulting vector.');
            return;
        end
        
        % default & assert
        [name,field] = deal(varargin{1:2});
        if ~ischar(name),  auxiliar_vector('help'); return; end
        if ~ischar(field), auxiliar_vector('help'); return; end
        
        % get vector
        switch field
            case {'subject','session','order','covariate'}, v = [];
            case {'main','name','version','onset'},         v = {};
            otherwise,                                      auxiliar_vector('help'); return;
        end
        for i_subject = 1:scan.running.subject.number
            ii_column = strcmp(scan.running.design(1).column.name,name);
            switch field
                case 'subject'
                    v = [v,repmat(i_subject,[1,sum(ii_column)])]; %#ok<*AGROW>
                case 'onset'
                    scan_tool_error(scan,'not implemented yet');
                otherwise
                    v = [v,scan.running.design(i_subject).column.(field)(ii_column)];
            end
        end
        
        % return
        varargout = {mat2vec(v)};
    end
end