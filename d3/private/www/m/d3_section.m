
function html = d3_section(section)
    %% html = D3_SECTION(section)
    % create section
    % see d3_html

    %% warnings
    %#ok<*AGROW>

    %% function
    html = '';
    html = [html,10];
    html = [html,'<!-- '];
    html = [html,section];
    html(end+1:30) = '-';
    html = [html,'-->',10];
    
end
