function varargout = steeze(varargin)
    varargout{:} = squeeze(nanste(varargin{:}));
end