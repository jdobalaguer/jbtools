
function obj = control_update_df(obj)
    %% obj = CONTROL_UPDATE_DF(obj)
    % update the edit with the degrees of freedom
    
    %% function
    disp('control_update_df');
    
    % get selected files
    ii_file = control_get_file(obj);
    
    % get maps
    u_df = {obj.dat.statistics(ii_file).df};
    n_df = length(u_df);
    
    % assert
    switch n_df
        case 0, df = nan;
        case 1, df = u_df{1};
        otherwise
            if isequal(u_df{:}), df = u_df{1};
            else                 df = nan; scan_tool_warning(obj.scan,false,'files have different degrees of freedom');
            end
    end
    
    % update
    h = obj.fig.control.figure;
    set(findobj(h,'Tag','DFEdit'),    'String',sprintf('%d',df));end
