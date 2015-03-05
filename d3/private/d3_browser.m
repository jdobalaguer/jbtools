
function d3_browser(url)
    %% D3_BROWSER([url])
    % opens a web browser on the specified url
    % see also d3_start
    %          d3_default
    %          d3_close
    %          d3_reply
    %          d3_browser
    %          d3_figure
    %          d3_example
    
    %% warnings
    
    %% function
    
    % defaults
    assertExist('url');
    
    % open a browser
    import('java.awt.Desktop');
    import('java.net.URI');
    desktop = Desktop.getDesktop();
    uri = URI(sprintf('http://%s',url));
    desktop.browse(uri);
    
end