function plot(varargin)
  
  palettable(); % setup shared across all palettable functions
  
  defaults = {'Marker', '.'};
  
  if(nargin > 1 && isnumeric(varargin{2}))
    h = builtin('plot', varargin{1:2}, defaults{:}, varargin{3:end});
  else
    h = builtin('plot', varargin{1}, defaults{:}, varargin{2:end});
  end
  
  xlabel('label me')
  ylabel('label me')
  
  f = gcf();
  
  % make the background white
  set(f,'Color',[1 1 1]);
  
  % kill the upper and right axis
  set(get(f,'CurrentAxes'), 'box', 'off');
end