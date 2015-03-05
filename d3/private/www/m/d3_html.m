
function html = d3_html(d3,request)
    %% html = D3_HTML(request,opts)
    % replies to one request in the queue
    % see also d3_start
    %          d3_default
    %          d3_close
    %          d3_reply
    %          d3_browser
    %          d3_figure
    %          d3_example

    %% warnings
    %#ok<*INUSD,*INUSL,*AGROW,*NASGU>

    %% function
    html = '';
    html = [html,'<html>',10];
    html = [html,get_txt('head.txt')];
    html = [html,get_txt('css.txt')];
    html = [html,get_txt('js.txt')];
    html = [html,'<body>',10];
    html = [html,get_m('d3_tab.m',d3,request)];
    html = [html,get_txt('script_tab.txt')];
    html = [html,get_txt('script_menu.txt')];
    html = [html,get_txt('script_m2j.txt')];
    html = [html,get_m('d3_chart.m',d3,request)];
    html = [html,'</body>',10];
    html = [html,'</html>',10];
    html = [html,get_txt('end.txt')];
        
end

%% auxiliar

% get txt files
function html = get_txt(filename)
    filename = [jbtools_root(),'/d3/private/www/txt/',filename];
    html = fileread(filename);
end
    
% get m files
function html = get_m(varargin)
    filename = [jbtools_root(),'/d3/private/www/m/',varargin{1}];
    [pathstr,name,ext] = fileparts(filename);
    addpath(pathstr);
    fhandle = str2func(name);
    html = feval(fhandle,varargin{2:end});
end


