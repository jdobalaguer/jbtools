
function scan = scan_function_glm_get_vector(scan)
    %% scan = SCAN_FUNCTION_GLM_GET_VECTOR(scan)
    % define function @get.vector
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function,   return; end
    if ~scan.running.flag.estimation, return; end
    scan.function.get.vector = @auxiliar_vector;
end

%% auxiliar
function varargout = auxiliar_vector(varargin)
    varargout = cell(1,nargin);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=3 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'v = @get.vector(scan,name,field)','This function loads or transform a vector so that it can index the vector of betas from @scan.function.get.beta. [name] is the name of a condition. [field] can be any of {''main'',''name'',''subject'',''session'',''version'',''order'',''covariate''}. [u] is a vector of same length than those in [scan.job.condition]. [v] is the the resulting vector.');
        return;
    end

    % default & assert
    [name,field] = varargin{2:3};
    if ~ischar(name),  auxiliar_vector(tcan,'help'); return; end
    if ~ischar(field), auxiliar_vector(tcan,'help'); return; end

    % get vector
    switch field
        case {'subject','session','order','covariate'}, v = [];
        case {'main','name','version'},                 v = {};
        case 'onset',                                   v = nan(size(auxiliar_vector(tcan,name,'subject'))); varargout = {mat2vec(v)}; return;
        otherwise,                                      auxiliar_vector(tcan,'help'); return;
    end
    for i_subject = 1:tcan.running.subject.number
        ii_column = strcmp(tcan.running.design(1).column.name,name);
        switch field
            case 'subject'
                v = [v,repmat(i_subject,[1,sum(ii_column)])]; %#ok<*AGROW>
            otherwise
                v = [v,tcan.running.design(i_subject).column.(field)(ii_column)];
        end
    end

    % return
    varargout = {mat2vec(v)};
end
