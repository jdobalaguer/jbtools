
function d3_browser(url)
    %% D3_BROWSER([url])
    % private function. opens a web browser on the specified url (similar to "web")
    % see also d3_help
    
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
