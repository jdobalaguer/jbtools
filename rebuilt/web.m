
function varargout = web(varargin)
    %% web(url)
    
    %% warnings
    
    %% function
    varargout = repmat({[]},1,nargout);
    url = varargin{1};
    import('java.awt.Desktop');
    import('java.net.URI');
    desktop = Desktop.getDesktop();
    uri = URI(url);
    desktop.browse(uri);    
end