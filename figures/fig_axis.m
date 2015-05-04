
function varargout = fig_axis(sa,ca)
  %% va = fig_axis(sa[,ca])
  % 
  % set axis features (labels, legend, title, ...)
  % 
  % ca = gca();
  % 
  % sa.xtick   = -1:0.5:+1;
  % sa.ytick   = -1:0.5:+1;
  % sa.ztick   = -1:0.5:+1;
  % sa.xminor  = 'on';
  % sa.yminor  = 'on';
  % sa.zminor  = 'on';
  % sa.xticklabel = {'-1',...}
  % sa.yticklabel = {'-1',...}
  % sa.zticklabel = {'-1',...}
  % sa.xgrid   = 'off';
  % sa.ygrid   = 'on';
  % sa.zgrid   = 'on';
  % sa.xlim    = [-1,+1];
  % sa.ylim    = [-1,+1];
  % sa.zlim    = [-1,+1];
  % sa.clim    = [-1,+1];
  % sa.xlabel = 'xlabel';
  % sa.ylabel = 'ylabel';
  % sa.zlabel = 'zlabel';
  % sa.ilegend = [obj1, obj2, ...];
  % sa.tlegend = {object 1','object 2'};
  % sa.title   = 'title';

  if ~exist('sa','var') || isempty(sa); sa = struct(); end
  if ~exist('ca','var') || isempty(ca); ca = gca();    end
  va = struct();

  %% axis
  % general
  set(ca, 'FontName','Verdana');
  set(ca, 'Box'         , 'off'     , ...
          'TickDir'     , 'out'     , ...
          'TickLength'  , [.02 .02] , ...
          'LineWidth'   , 1         );
  set(get(gcf,'CurrentAxes'), 'box', 'off');
  set(get(gcf,'CurrentAxes'),'layer','top');
        
  % xtick
  if isfield(sa,{'xtick'})
    set(ca,   'XTick',sa.xtick);
  end
  % xminor
  if isfield(sa,{'xminor'})
    set(ca,   'XMinorTick',sa.xminor);
  end
  % ygrid
  if isfield(sa,{'xgrid'})
    set(ca,   'XGrid'     , sa.xgrid);
  end
  % xticklabel
  if isfield(sa,{'xticklabel'})
    set(ca,   'XTickLabel',sa.xticklabel);
  end
  % xlim
  if isfield(sa,{'xlim'})
      xlim(sa.xlim);
  end
  % ytick
  if isfield(sa,{'ytick'})
    set(ca,   'YTick'     , sa.ytick);
  end
  % yminor
  if isfield(sa,{'yminor'})
    set(ca,   'YMinorTick',sa.yminor);
  end
  % ygrid
  if isfield(sa,{'ygrid'})
    set(ca,   'YGrid'     , sa.ygrid);
  end
  % yticklabel
  if isfield(sa,{'yticklabel'})
    set(ca,   'YTickLabel',sa.yticklabel);
  end
  % ylim
  if isfield(sa,{'ylim'})
      ylim(sa.ylim);
  end
  % ztick
  if isfield(sa,{'ztick'})
    set(ca,   'ZTick'     , sa.ztick);
  end
  % zminor
  if isfield(sa,{'zminor'})
    set(ca,   'ZMinorTick',sa.zminor);
  end
  % zgrid
  if isfield(sa,{'zgrid'})
    set(ca,   'ZGrid'     , sa.zgrid);
  end
  % zticklabel
  if isfield(sa,{'zticklabel'})
    set(ca,   'ZTickLabel',sa.zticklabel);
  end
  % zlim
  if isfield(sa,{'zlim'})
      zlim(sa.zlim);
  end
  % clim
  if isfield(sa,{'clim'})
      set(gca(),'clim',sa.clim);
  end
  % xlabel
  if isfield(sa,{'xlabel'})
    va.xlabel = xlabel(sa.xlabel);
  end
  % ylabel
  if isfield(sa,{'ylabel'})
    va.ylabel = ylabel(sa.ylabel);
  end
  % zlabel
  if isfield(sa,{'zlabel'})
    va.zlabel = zlabel(sa.zlabel);
  end
  % title
  if isfield(sa,{'title'})
    va.title  = title (sa.title);
    set(va.title,'FontWeight','bold');
  end
  % legend
  if isfield(sa,{'ilegend','tlegend'})
    va.hlegend = legend(sa.ilegend,sa.tlegend,'location','NorthWest');
  end
  
  %% output
  if nargout; varargout{1} = va; end
end
