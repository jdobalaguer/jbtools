
function html = d3_tab(d3,request)
    %% html = D3_TAB(d3,request)
    % create tabs
    % see d3_html

    %% warnings
    %#ok<*INUSD>
    %#ok<*AGROW>

    %% function
    u_tab = unique([d3.opts.data.fig]);
    
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
        html = [html,'"></div>',10];
    end
    
    % tail
    html = [html,'</div>',10];
    
    % canvas
    html = [html,'<script type="text/javascript">',10];
    html = [html,'  svg = [];',10];
    for tab = u_tab
        html = [html,'  svg[',num2str(tab),'] = dimple.newSvg("#tab',num2str(tab),'", 590, 400);',10];
    end
    html = [html,'</script>',10];
    
    % menu
    html = [html,'  <div class="tabs">',10];
    html = [html,'    <a class="tab" href="javascript:void(0);">Save</a>',10];
    html = [html,'    <a class="tab" href="javascript:void(0);">Print</a>',10];
    html = [html,'  </div>',10];
    
end
