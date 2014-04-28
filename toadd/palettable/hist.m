function varargout = hist(varargin)
  
  palettable(); % setup shared across all palettable functions
    
  % temporarily move palettable to lowest precedence
  d = palettabledir;
  addpath(d, '-end');
  
  % suppress warning for overloading function
  warning off MATLAB:dispatcher:nameConflict

  if nargout,   varargout{:} = hist(varargin{:});
  else                         hist(varargin{:}); end
  
  f = gcf();
  
  % make the background white
  set(f,'Color',[1 1 1]);
  
  % kill the upper and right axis
  set(get(f,'CurrentAxes'), 'box', 'off');

  % make the bars grey with small white borders
  h = findobj(f,'Type','patch');
  set(h,'FaceColor',[0.7 0.7 0.7],'EdgeColor',[1 1 1]);
  
  % bring the axis to front
  set(get(f,'CurrentAxes'),'layer','top');
  
  % return palettable to high precedence
  addpath(d, '-begin')
end