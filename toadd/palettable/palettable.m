% these are shared across all the palettable plotting functions
% ideally, they should go in startup.m so that it happens automatically
function palettable()
  
  % set the default colormap colors
  c = colors();           
  set(0,'DefaultAxesColorOrder', colors);
  
end