
function html = d3_tab(d3)
    %% html = D3_TAB(d3)
    % create tabs
    % see d3_html

    %% warnings
    %#ok<*AGROW>

    %% function
    u_tab = unique(d3.opts.summ.fig.handle);
    n_tab = length(u_tab);
    
    html = '';
    
    % head
    html = [html,'<div class="tabs">',10];
    
    % tab
    for tab = u_tab
        html = [html,'  <a data-tab="',num2str(tab),'" class="tab'];
        if tab==u_tab(1),
            html = [html,' active'];
        end
        html = [html,'">Figure ',num2str(tab),'</a>',10];
    end
    
    % content
    for tab = u_tab
        html = [html,'  <div id="tab',num2str(tab),'" data-content="',num2str(tab),'" class="content'];
        if tab==u_tab(1),
            html = [html,' active'];
        end
        html = [html,'">',10];
        % fig
        html = [html,'    <div id="fig',num2str(tab),'" ></div>',10];
        % menu
        html = [html,'    <div class="tabs">',10];
        html = [html,'      <a class="tab" href="javascript:menu_showSVG(',num2str(tab),');">Show SVG</a>',10];
        html = [html,'      <a class="tab" href="javascript:menu_showPNG(',num2str(tab),');">Show PNG</a>',10];
        html = [html,'      <a class="tab" href="javascript:menu_saveSVG(',num2str(tab),');">Save SVG</a>',10];
        html = [html,'      <a class="tab" href="javascript:menu_savePNG(',num2str(tab),');">Save PNG</a>',10];
        html = [html,'    </div>',10];
        % /content
        html = [html,'  </div>',10];
    end
    
    % tail
    html = [html,'</div>',10];
    
    % canvas
    html = [html,'<script type="text/javascript">',10];
    html = [html,'  svg = [];',10];
    for i_tab = 1:n_tab
        tab = u_tab(i_tab);
        html = [html,'  svg[',num2str(tab),'] = dimple.newSvg("#fig',num2str(tab),'",',num2str(d3.opts.summ.fig.size.x(i_tab)),',',num2str(d3.opts.summ.fig.size.y(i_tab)),');',10];
        html = [html,'  jQuery($(fig',num2str(tab),').children()[0]).attr("id","svg',num2str(tab),'");',10];
    end
    html = [html,'</script>',10];
    
    
end
