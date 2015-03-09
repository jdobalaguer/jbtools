function html = d3_chart(d3) 
    %% html = D3_CHART(d3)
    % set charts

    %% warnings
    %#ok<*INUSL,*AGROW,*NASGU>

    %% function
    
    html = '';
    u_data = d3.opts.data;
    n_data = length(u_data);
    summ = d3.opts.summ;
    for i_data = 1:n_data
        data = u_data(i_data);
        html = [html,get_m('d3_section.m',['SCRIPT TAB: ',data.styl.chart])];
        html = [html,get_m(['d3_chart_',data.styl.chart,'.m'],data,summ)];
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

