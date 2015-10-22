
function d3 = d3_close(d3)
    %% D3_CLOSE(d3)
    % private function. closes the web-server
    % see also d3_help
    
    %% function
    d3.TCP = webserver_run('JavaTcpServer','close',d3.TCP,[],[]);
end
