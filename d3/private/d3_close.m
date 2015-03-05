
function d3 = d3_close(d3)
    %% D3_CLOSE(d3)
    % closes the webserver
    % see also d3_start
    %          d3_default
    %          d3_close
    %          d3_reply
    %          d3_browser
    %          d3_figure
    %          d3_example
    
    %% warnings
    
    %% function
    d3.TCP = JavaTcpServer('close',d3.TCP,[],[]);

end