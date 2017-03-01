
function varargout = fig_axis(varargin)
  %% va = FIG_AXIS(sa[,ca])
  % va = FIG_AXIS(f1,v1[,f2,v2][,..,..][,ca])
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
  % sa.tlegend = {'object 1','object 2'};
  % sa.plegend = 'SouthEast';
  % sa.title   = 'title';
  % sa.ratio   = [1,1];
  % sa.box     = 'on';

  %% input
  func_default('varargin',{struct()});
  if isstruct(varargin{1}) && nargin==1
      sa = varargin{1};
      ca = [];
  elseif isstruct(varargin{1}) && nargin==2
      [sa,ca] = deal(varargin{:});
  else
      assertString(varargin{1:2:end});
      if mod(nargin,2)
          sa = pair2struct(varargin{1:end-1});
          ca = varargin{end};
      else
          sa = pair2struct(varargin{1:end});
          ca = [];
      end
      
  end
  func_default('sa',struct());
  func_default('ca',gca());
  va = struct();

  %% axis
  % general
  set(ca, 'FontName','Verdana');
  set(ca, 'Box'         , 'off'     , ...
          'TickDir'     , 'out'     ); %'LineWidth', 1
  set(ca,'TickLength',[0.01,0.025]);
  set(get(gcf,'CurrentAxes'), 'box', 'off');
  set(get(gcf,'CurrentAxes'),'layer','top');
        
  %% x & y
  % xytick
  if isfield(sa,{'xytick'})
      sa.xtick = sa.xytick;
      sa.ytick = sa.xytick;
      sa.ztick = sa.xytick;
  end
  % xylim
  if isfield(sa,{'xylim'})
      sa.xlim = sa.xylim;
      sa.ylim = sa.xylim;
      sa.zlim = sa.xylim;
  end
  % xycolor
  if isfield(sa,{'xycolor'})
      sa.xcolor = sa.xycolor;
      sa.ycolor = sa.xycolor;
  end
  % xycolor
  if isfield(sa,{'xygrid'})
      sa.xgrid = sa.xygrid;
      sa.ygrid = sa.xygrid;
  end
  
  %% x
  % xtick
  if isfield(sa,{'xtick'})
    set(ca,   'XTick',sa.xtick);
  end
  % xminor
  if isfield(sa,{'xminor'})
    set(ca,   'XMinorTick',sa.xminor);
  end
  % xgrid
  if isfield(sa,{'xgrid'})
    set(ca,   'XGrid'     , sa.xgrid);
  end
  % xticklabel
  if isfield(sa,{'xticklabel'})
    set(ca,   'XTickLabel',sa.xticklabel);
  end
  % xrotation
  if isfield(sa,{'xrotation'})
    set(ca,   'XTickLabelRotation',sa.xrotation);
  end
  % xlim
  if isfield(sa,{'xlim'})
      xlim(sa.xlim);
  end
  % xcolor
  if isfield(sa,{'xcolor'})
      set(ca,'XColor',sa.xcolor);
  end
  % xlabel
  if isfield(sa,{'xlabel'})
    va.xlabel = xlabel(sa.xlabel);
  end
  
  %% y
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
  % yrotation
  if isfield(sa,{'yrotation'})
    set(ca,   'YTickLabelRotation',sa.yrotation);
  end
  % ylim
  if isfield(sa,{'ylim'})
      ylim(sa.ylim);
  end
  % ycolor
  if isfield(sa,{'ycolor'})
      set(ca,'YColor',sa.ycolor);
  end
  % ylabel
  if isfield(sa,{'ylabel'})
    va.ylabel = ylabel(sa.ylabel);
  end
  
  %% z
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
  % zlabel
  if isfield(sa,{'zlabel'})
    va.zlabel = zlabel(sa.zlabel);
  end
  
  %% c
  % clim
  if isfield(sa,{'clim'})
      set(gca(),'clim',sa.clim);
  end
  
  %% axis
  % title
  if isfield(sa,{'title'})
    va.title  = title (sa.title);
    set(va.title,'FontWeight','bold');
  end
  % legend
  if isfield(sa,{'ilegend','tlegend'})
    if ~isfield(sa,'plegend'), sa.plegend = 'NorthWest'; end
    va.hlegend = legend(sa.ilegend,sa.tlegend,'location',sa.plegend);
  end
  % visible
  if isfield(sa,{'visible'})
      set(ca,'visible',sa.visible);
  end
  % ratio
  if isfield(sa,{'ratio'})
      sa.ratio(end+1:3) = 1;
      set(ca,'PlotBoxAspectRatio',sa.ratio);
  end
  % box
  if isfield(sa,{'box'})
    set(ca,'Box',sa.box);
  end
  
  %% output
  if nargout; varargout{1} = va; end
end
