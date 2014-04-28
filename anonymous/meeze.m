function varargout = meeze(varargin)
    varargout{:} = squeeze(mean(varargin{:}));
end