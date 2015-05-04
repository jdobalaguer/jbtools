
function varargout = web(url)
    %% WEB(url)
    % open a web page
    
    %% warnings
    
    %% function
    varargout = repmat({[]},1,nargout);
    import('java.awt.Desktop');
    import('java.net.URI');
    desktop = Desktop.getDesktop();
    uri = URI(url);
    desktop.browse(uri);    
end