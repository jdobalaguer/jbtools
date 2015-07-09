
function scan = scan_function_tbte_get_vector(scan)
    %% scan = SCAN_FUNCTION_TBTE_GET_VECTOR(scan)
    % define function @get.vector
    % to list main functions, try
    %   >> help scan;

    %% notes
    % tiny hack: it works based on the idea that 2 onsets are never exactly equal
    % it ignores the order, but that kind of makes sense because the vector doesn't depend on the order.
    
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
        scan_tool_help(tcan,'v = @get.vector(scan,i_subject,i_session,order,name,field)\nv = @get.vector(scan,name,u)','This function loads or transform a vector so that it can index the vector of betas from @scan.function.get.beta. [name] is the name of a condition. [field] can be any of {''main'',''name'',''subject'',''session'',''version'',''order'',''covariate''}. [u] is a vector of same length than those in [scan.job.condition]. [v] is the the resulting vector.');
        return;
    end

    % default & assert
    [i_subject,i_session,order] = varargin{2:4};
    name = varargin{5};
    if ~ischar(name), auxiliar_vector(tcan,'help'); return; end
    if ischar(varargin{6}), field = varargin{6};
    else                    u = varargin{6};
    end
    func_default('field','');
    func_default('u',[]);
    
    % field mode
    if field
        ii_session = (tcan.running.design(i_subject).column.session == i_session);
        ii_order   = (tcan.running.design(i_subject).column.order   == order);
        ii_name    = strcmp(tcan.running.design(i_subject).column.name,name);
        ii_column  = (ii_session & ii_order & ii_name);
        switch field
            case 'onset'
                onset = [tcan.running.condition{i_subject}{i_session}.onset];
                ii_name = strcmp({tcan.running.condition{i_subject}{i_session}.name},name);
                onset = onset(ii_name);
                varargout = {mat2vec(onset)};
                return;
            case 'subject'
                    v = repmat(i_subject,[1,sum(ii_column)]);
            case {'session','order','covariate','main','name','version'}
                    v = tcan.running.design(i_subject).column.(field)(ii_column);
            otherwise, auxiliar_vector(tcan,'help'); return;
        end
        varargout = {mat2vec(v)}; return;
    end

    % assert length
    if isempty(u), auxiliar_vector(tcan,'help'); return; end
    
    % vector mode
    subject   = tcan.function.get.vector(tcan,i_subject,i_session,order,name,'subject');
    session   = tcan.function.get.vector(tcan,i_subject,i_session,order,name,'session');
    onset     = tcan.function.get.vector(tcan,i_subject,i_session,order,name,'onset');
    condition = tcan.job.condition(strcmp(name,{tcan.job.condition.name}));
    ii_subject = (condition.subject == tcan.running.subject.unique(i_subject));
    ii_session = (condition.session == i_session);
    ii_onset   = ismember(condition.onset,onset);
    condition.subject = condition.subject(ii_subject & ii_session & ii_onset);
    condition.session = condition.session(ii_subject & ii_session & ii_onset);
    condition.onset   = condition.onset  (ii_subject & ii_session & ii_onset);
    u = u(ii_subject & ii_session & ii_onset);
    if islogical(u) || isnumeric(u)
        v = nan(size(u));
    elseif iscell(u)
        v = cell(size(u));
    else
        auxiliar_vector(tcan,'help'); return;
    end
    for i = 1:length(u)
        ii_subject = (tcan.running.subject.unique(subject(i)) == condition.subject);
        ii_session = (session(i)                              == condition.session);
        ii_onset   = (onset(i)                                == condition.onset);
        v(i) = u(ii_subject & ii_session & ii_onset);
    end
    varargout = {mat2vec(v)}; return;
end
