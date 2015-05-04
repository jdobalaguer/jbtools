function varargout = fig_plot(varargin)
  
  % set colours
  original_colours = get(0,'DefaultAxesColorOrder');
  set(gcf,'DefaultAxesColorOrder',fig_color('clovers'));
  
  % plot
  defaults = {'LineStyle','--','Marker','.', 'MarkerSize', 26};
  
  if(nargin > 1 && isnumeric(varargin{2}) && all(size(varargin{1})==size(varargin{2})))
    ret = plot(varargin{1:2}, defaults{:}, varargin{3:end});
  else
    ret = plot(varargin{1}, defaults{:}, varargin{2:end});
  end
  
  % set colours back
  set(gcf,'DefaultAxesColorOrder',original_colours);
  
  % argout
  if nargout, varargout = {ret}; end
  
end