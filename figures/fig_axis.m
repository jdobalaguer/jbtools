
function varargout = fig_axis(sa,ca)
  %% va = fig_axis(sa[,ca])
  % 
  % set axis features (labels, legend, title, ...)
  % 
  % ca = gca();
  % 
  % sa.xtick   = -1:0.5:+1;
  % sa.ytick   = -1:0.5:+1;
  % sa.xticklabel = {'-1',...}
  % sa.yticklabel = {'-1',...}
  % sa.xgrid   = 'off';
  % sa.ygrid   = 'on';
  % sa.xlim    = [-1,+1];
  % sa.ylim    = [-1,+1];
  % sa.xlabel = 'xlabel';
  % sa.ylabel = 'ylabel';
  % sa.ilegend = [obj1, obj2, ...];
  % sa.tlegend = {object 1','object 2'};
  % sa.title   = 'title';
  %

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
    set(ca,   'XMinorTick','on', ...
              'XTick',sa.xtick);
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
    set(ca,   'YMinorTick', 'on', ...
              'YTick'     , sa.ytick);
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
  % xlabel
  if isfield(sa,{'xlabel'})
    va.xlabel = xlabel(sa.xlabel);
    set(va.xlabel,'FontName','Verdana');
    set(va.xlabel,'FontSize',14);
  end
  % ylabel
  if isfield(sa,{'ylabel'})
    va.ylabel = ylabel(sa.ylabel);
    set(va.ylabel,'FontName','Verdana');
    set(va.ylabel,'FontSize',14);
  end
  % title
  if isfield(sa,{'title'})
    va.title  = title (sa.title);
    set(va.title,'FontName','Verdana');
    set(va.title,'FontWeight','bold');
    set(va.title,'FontSize',14);
  end
  % legend
  if isfield(sa,{'ilegend','tlegend'})
    va.hlegend = legend(sa.ilegend,sa.tlegend,'location','NorthWest');
    set(va.hlegend,'FontName','Verdana');
    set(va.hlegend,'FontSize',14);
  end
  
  %% output
  if nargout; varargout{1} = va; end
end
