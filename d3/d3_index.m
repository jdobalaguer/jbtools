
function html = d3_index(request,opts)
    %% html = D3_INDEX(request,opts)

    %% warnings
    %#ok<*INUSD,*INUSL,*AGROW>

    %% function
    html = '';
    html = [html,'<html>',10];
    html = [html,print_head()];
    html = [html,print_css()];
    html = [html,print_js()];
    html = [html,'<body>',10];
    html = [html,'<div class="tabs">',10];
    for i_tab = 1:length(opts.extra), html = [html,print_tab_button( i_tab,                  i_tab==1)]; end
    for i_tab = 1:length(opts.extra), html = [html,print_tab_content(i_tab,opts.extra(i_tab),i_tab==1)]; end
    html = [html,'</div>',10];
    html = [html,print_tab_script()];
    html = [html,'</body>',10];
    html = [html,'</html>',10];
%     html = [html,print_end()];
        
end

%% AUXILIAR: html
function html = print_head()
    html = ['<head>',10,...
            '  <meta content="text/html;charset=utf-8" http-equiv="Content-Type">',10,...
            '  <meta content="utf-8" http-equiv="encoding">',10,...
            '</head>',10];
end
function html = print_end()
    html = ['<script src="end" />',10];
end

%% AUXILIAR: import
function html = print_css()
    html = ['<link rel="stylesheet" type="text/css" media="all" href="css/tabs.css" />',10];
end
function html = print_js()
    html = [     '<script src="js/d3.min.js"      charset="utf-8"></script>',10];
    html = [html,'<script src="js/jquery.min.js"  charset="utf-8"></script>',10];
end

%% AUXILIAR: tabs
function html = print_tab_button(i_tab,active)
    html = ['  <a data-tab="',num2str(i_tab),'" class="tab'];
    if active, html = [html,' active']; end
    html = [html,'">Figure ',num2str(i_tab),'</a>',10];
end
function html = print_tab_content(i_tab,data,active)
    html = ['  <div data-content="',num2str(i_tab),'" class="content'];
    if active, html = [html,' active']; end
    html = [html,'">',10];
    html = [html,'Figure ',num2str(data),' Content',10];
    html = [html,'</div>',10];
end
function html = print_tab_script()
    html = ['  <script>',10,...
            '    $(function () {',10,...
            '      $(''[data-tab]'').on(''click'', function (e) {',10,...
            '        $(this)',10,...
            '        .addClass(''active'')',10,...
            '        .siblings(''[data-tab]'')',10,...
            '        .removeClass(''active'')',10,...
            '        .siblings(''[data-content='' + $(this).data(''tab'') + '']'')',10,...
            '        .addClass(''active'')',10,...
            '        .siblings(''[data-content]'')',10,...
            '        .removeClass(''active'');',10,...
            '        e.preventDefault();',10,...
            '      });',10,...
            '    });',10,...
            '  </script>',10];
end

%% AUXILIAR: 