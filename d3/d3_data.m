
function data = d3_data(varargin)
    %% data = D3_DATA(fig,chart,...)
    % d3_data('plot',x,y)
    
    %% warnings
    
    %% function
    data = struct();
    data.fig   = varargin{1};
    data.chart = varargin{2};
    switch(data.chart)
        
        case 'plot'
            data.axis = struct();
            data.vals.x = varargin{3};
            data.vals.y = varargin{4};
            
        case 'grid2D'
            data.axis   = struct();
            data.vals.m = varargin{3};
            
        otherwise
            error('d3_data: error. chart "%s" not recognised',data.chart);
    end
    
    defs = d3_data_default();
    data = parser(data,defs);
    
end