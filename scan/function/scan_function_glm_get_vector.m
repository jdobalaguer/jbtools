
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
    varargout = cell(1,nargout);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=6 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'v = @get.vector(scan,i_subject,i_session,order,name,field)','This function loads or transform a vector so that it can index the vector of betas from @scan.function.get.beta. [name] is the name of a condition. [field] can be any of {''main'',''name'',''subject'',''session'',''version'',''order'',''covariate''}. [u] is a vector of same length than those in [scan.job.condition]. [v] is the the resulting vector.');
        return;
    end

    % default & assert
    [i_subject,i_session,order,name,field] = varargin{2:6};
    if ~ischar(name),  auxiliar_vector(tcan,'help'); return; end
    if ~ischar(field), auxiliar_vector(tcan,'help'); return; end

    % get vector
    ii_column = strcmp(tcan.running.design(i_subject).column.name,name);
    switch field
        case 'onset'
            v = nan(size(auxiliar_vector(tcan,i_subject,i_session,order,name,'subject'))); varargout = {mat2vec(v)}; return;
        case 'subject'
            v = repmat(tcan.running.subject.unique(i_subject),[1,sum(ii_column)]);
        case {'session','order','covariate','main','name','version'}
            v = tcan.running.design(i_subject).column.(field)(ii_column);
        otherwise
            auxiliar_vector(tcan,'help'); return;
    end
    
    % choose session/order
    % remove covariates
    ii_column  = strcmp(tcan.running.design(i_subject).column.name,name);
    u_session  = tcan.running.design(i_subject).column.session(ii_column);
    u_order    = tcan.running.design(i_subject).column.order(ii_column);
    covariate  = tcan.running.design(i_subject).column.covariate(ii_column);
    
    ii_session   = (u_session == i_session);
    ii_order     = (u_order   == order);
    ii_covariate = (~covariate);
    v = v(ii_session & ii_order & ii_covariate);

    % return
    varargout = {mat2vec(v)};
end
