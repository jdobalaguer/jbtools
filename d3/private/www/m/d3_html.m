
function html = d3_html(d3)
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
    %#ok<*INUSL,*AGROW,*NASGU>

    %% function
    html = '';
    html = [html,'<html>',10];
    html = [html,get_m('d3_section.m','HEAD'),get_txt('head.txt')];
    html = [html,get_m('d3_section.m','CSS'), get_txt('css.txt')];
    html = [html,get_m('d3_section.m','JS'),  get_txt('js.txt')];
    html = [html,'<body>',10];
    html = [html,get_m('d3_section.m','SCRIPT TAB'), get_txt('script_tab.txt')];
    html = [html,get_m('d3_section.m','SCRIPT MENU'),get_txt('script_menu.txt')];
    html = [html,get_m('d3_section.m','SCRIPT M2J'), get_txt('script_m2j.txt')];
    html = [html,get_m('d3_section.m','TABS'),       get_m('d3_tab.m',d3)];
    html = [html,get_m('d3_section.m','AXIS'),       get_m('d3_axis.m',d3)];
    html = [html,get_m('d3_section.m','CHARTS'),     get_m('d3_chart.m',d3)];
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


