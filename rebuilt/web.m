
function varargout = web(varargin)
    %% WEB(url)
    % open a web page
    
    %% warnings
    
    %% function
    
    url = varargin{1}; % for compatibility, e.g. when profsave calls web..
    
    varargout = repmat({[]},1,nargout);
    import('java.awt.Desktop');
    import('java.net.URI');
    desktop = Desktop.getDesktop();
    uri = URI(url);
    desktop.browse(uri);    
end