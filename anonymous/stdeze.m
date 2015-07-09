
function varargout = stdeze(varargin)
    varargout{:} = squeeze(nanstd(varargin{:}));
end