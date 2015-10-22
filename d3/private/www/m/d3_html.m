
function html = d3_html(d3)
    %% html = D3_HTML(request,opts)
    % private function. replies to one request in the queue
    % see also d3_help

    %% function
    html = '';
    html = [html,'<html>',10];
    html = [html,get_m('d3_section.m','HEAD'),       get_txt('head.txt')];
    html = [html,get_m('d3_section.m','CSS'),        get_txt('css.txt')];
    html = [html,get_m('d3_section.m','EXTERNAL'),   get_txt('external.txt')];
    html = [html,get_m('d3_section.m','JS'),         get_txt('js.txt')];
    html = [html,'<body>',10];
    html = [html,get_m('d3_section.m','TABS'),       get_m('d3_tab.m',d3)];
    html = [html,'</body>',10];
    html = [html,get_m('d3_section.m','AXIS'),       get_m('d3_axis.m',d3)];
    html = [html,get_m('d3_section.m','CHARTS'),     get_m('d3_chart.m',d3)];
    html = [html,'</html>',10];
%     html = [html,get_txt('end.txt')];
end
