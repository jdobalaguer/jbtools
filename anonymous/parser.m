
function [optout,ret] = parser(optin,def)
    %% [optout,ret] = PARSER(optin,def)
    % optin     - input options
    %             format :  strings and values interleaved (e.g. varargin)
    %                       OR a struct with same format as default
    %                       OR 'paramters'
    %                       OR 'default'
    % def       - a struct with default values
    % optout    - output options
    % ret       - return
    
    %% warnings
    
    %% function
    
    % assert
    assert(isstruct(def),                       'parser: error. [default] is not a struct');
    assert(isstruct(optin) || iscell(optin),    'parser: error. [optin] has wrong format');
    
    % default
    optout = def;
    ret    = false;
    nowa   = false;
    
    % meta
    if iscell(optin)
        if strcmp(optin,'parameters')
            print_parameters(def);
            ret = true;
            return;
        end
        if strcmp(optin,'default')
            print_default(def);
            ret = true;
            return;
        end
        if any(strcmp(optin,'no_warning'))
            optin(strcmp(optin,'no_warning')) = [];
            nowa = true;
        end
    end
    
    % optin = optin{1}
    while iscell(optin) && isscalar(optin)
        optin = optin{1};
    end
    
    % cell2struct
    if iscell(optin)
        assert(even(length(optin)),       'parser: error. [optin] wrong format')
        args = optin(1:2:end);
        assert(all(cellfun(@isstr,args)), 'parser: error. [optin] wrong format');
        for i = 2:2:length(optin)
            optin{i} = {optin{i}};
        end
        optin = struct(optin{:});
    end
    
    % add
    optout = struct_add(def,optin);
    
    % extra
    assertWarning(nowa || struct_cmp(optout,def),'parser: warning. some parameters were not included as default');
    
end

%% auxiliar
function print_parameters(def)
    u = fieldnames(def);
    n = length(u);
    head = sprintf('%s: parameters:',caller(2));
    for i = 1:n
        fprintf('%s [%s] \n',head,u{i});
        head(:) = ' ';
    end
end

%% auxiliar
function print_default(def)
    u = fieldnames(def);
    n = length(u);
    head = sprintf('%s: parameters:',caller(2));
    for i = 1:n
        f = u{i};
        v = def.(f);
        if isscalar(v)
            switch class(v)
                case 'char'
                    fprintf('%s [%s] = ''%s'' \n',head,f,v);
                case {'double','single'}
                    fprintf('%s [%s] = %f \n',head,f,v);
                case {'logical','int8','uint8','int16','uint16','int32','uint32','int64','uint64'}
                    fprintf('%s [%s] = %f \n',head,f,v);
                case 'function_handle'
                    fprintf('%s [%s] = [function @%s] \n',head,f,func2str(v));
                otherwise
                    fprintf('%s [%s] = [%s] \n',head,f,class(v));
            end
        elseif isvector(v)
            switch class(v)
                case 'char'
                    fprintf('%s [%s] = ''%s'' \n',head,f,v);
                otherwise
                    fprintf('%s [%s] = [%s of length = %d]\n',head,f,class(v),length(v));
            end
        else
            fprintf('%s [%s] = [%s of size = %d',head,f,class(v),size(v,1));
            fprintf('x%d',sizep(v,2:ndims(v)));
            fprintf(']\n');
        end
        head(:) = ' ';
    end
end
