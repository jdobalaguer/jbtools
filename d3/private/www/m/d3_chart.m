function html = d3_chart(d3,request) 
    %% html = D3_CHART(d3,request)
    % set charts

    %% warnings
    %#ok<*INUSL,*INUSD,*AGROW,*NASGU>

    %% function
    
    html = '';
    u_data = d3.opts.data;
    n_data = length(u_data);
    for i_data = 1:n_data
        data = u_data(i_data);
        html = [html,get_m(['d3_chart_',data.chart,'.m'],data)];
    end
end

%% auxiliar

% get m files
function html = get_m(varargin)
    filename = [jbtools_root(),'/d3/private/www/m/',varargin{1}];
    [pathstr,name,ext] = fileparts(filename);
    addpath(pathstr);
    fhandle = str2func(name);
    html = feval(fhandle,varargin{2:end});
end

