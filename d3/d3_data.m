
function data = d3_data(varargin)
    %% data = D3_DATA(fig,chart,...)
    % d3_data(h,'plot',x,y,..)
    
    %% warnings
    
    %% function
    if ~nargin, data = repmat(d3_data_default(),[1,0]); return; end
    
    data = struct();
    data.fig.handle  = varargin{1};
    data.styl.chart  = varargin{2};
    switch(data.styl.chart)
        
        case 'plot'
            data.vals.x = varargin{3};
            data.vals.y = varargin{4};
            data = struct_deep(parser(['no_warning',varargin(5:end)],struct_flat(data)));
            
        otherwise
            error('d3_data: error. chart "%s" not recognised',data.styl.chart);
    end
    
    defs = d3_data_default();
    data = struct_deep(parser(struct_flat(data),struct_flat(defs)));
    
end