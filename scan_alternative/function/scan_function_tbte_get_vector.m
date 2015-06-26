
function scan = scan_function_tbte_get_vector(scan)
    %% scan = SCAN_FUNCTION_TBTE_GET_VECTOR(scan)
    % define function @get.vector
    % to list main functions, try
    %   >> help scan;

    %% notes
    % this only works with TBTE. it doesn't allow multiple orders
    % tiny hack: it works based on the idea that 2 onsets are never exactly equal
    
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
        scan_tool_help(tcan,'v = @get.vector(scan,name,field)\nv = @get.vector(scan,name,u)','This function loads or transform a vector so that it can index the vector of betas from @scan.function.get.beta. [name] is the name of a condition. [field] can be any of {''main'',''name'',''subject'',''session'',''version'',''order'',''covariate''}. [u] is a vector of same length than those in [scan.job.condition]. [v] is the the resulting vector.');
        return;
    end

    % default & assert
    name = varargin{2};
    if ~ischar(name)
        auxiliar_vector(tcan,'help'); return;
    end
    if ischar(varargin{3})
        field = varargin{3};
    else
        u = varargin{3};
    end
    func_default('field','');
    func_default('u',[]);
    
    % field mode
    if field
        switch field
            case 'onset'
                onset = cell_flat(tcan.running.condition);
                onset = [onset{:}];
                onset = onset(strcmp(name,{onset.name}));
                onset = mat2vec(onset);
                onset = cell2mat({onset.onset}');
                varargout = {mat2vec(onset)};
                return;
            case {'subject','session','order','covariate'}, v = [];
            case {'main','name','version'},         v = {};
            otherwise, auxiliar_vector(tcan,'help'); return;
        end
        for i_subject = 1:tcan.running.subject.number
            ii_column = strcmp(tcan.running.design(i_subject).column.name,name);
            switch field
                case 'subject'
                    v = [v,repmat(i_subject,[1,sum(ii_column)])]; %#ok<*AGROW>
                case 'onset'
                    scan_tool_error(tcan,'not implemented yet');
                otherwise
                    v = [v,tcan.running.design(i_subject).column.(field)(ii_column)];
            end
        end
        varargout = {mat2vec(v)}; return;
    end

    % assert length
    if isempty(u), auxiliar_vector(tcan,'help'); return; end
    
    % vector mode
    if islogical(u) || isnumeric(u)
        subject   = tcan.function.get.vector(tcan,name,'subject');
        session   = tcan.function.get.vector(tcan,name,'session');
        onset     = tcan.function.get.vector(tcan,name,'onset');
        condition = tcan.job.condition(strcmp(name,{tcan.job.condition.name}));
        ii_onset  = ismember(condition.onset,onset);
        condition.subject = condition.subject(ii_onset);
        condition.session = condition.session(ii_onset);
        condition.onset   = condition.onset(ii_onset);
        u = u(ii_onset);
        v = nan(size(u));
        for i = 1:length(u)
            ii_subject = (tcan.running.subject.unique(subject(i)) == condition.subject);
            ii_session = (session(i)                              == condition.session);
            ii_onset   = (onset(i)                                == condition.onset);
            v(i) = u(ii_subject & ii_session & ii_onset);
        end
        varargout = {mat2vec(v)}; return;
    end
    
    % cell mode
    if iscell(u)
        subject   = tcan.function.get.vector(tcan,name,'subject');
        session   = tcan.function.get.vector(tcan,name,'session');
        onset     = tcan.function.get.vector(tcan,name,'onset');
        condition = tcan.job.condition(strcmp(name,{tcan.job.condition.name}));
        ii_onset  = ismember(condition.onset,onset);
        condition.subject = condition.subject(ii_onset);
        condition.session = condition.session(ii_onset);
        condition.onset   = condition.onset(ii_onset);
        u = u(ii_onset);
        v = cell(size(u));
        for i = 1:length(u)
            ii_subject = (tcan.running.subject.unique(subject(i)) == condition.subject);
            ii_session = (session(i)                              == condition.session);
            ii_onset   = (onset(i)                                == condition.onset);
            v(i) = u(ii_subject & ii_session & ii_onset);
        end
        varargout = {mat2vec(v)}; return;
    end

    % you shouldnt be here
    auxiliar_vector(tcan,'help'); return;
end
