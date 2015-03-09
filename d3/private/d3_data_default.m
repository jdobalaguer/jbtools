
function defs = d3_data_default()
    %% defs = D3_DATA_DEFAULT()
    % default configuration for the web-server
    % see also d3_start
    %          d3_start_default
    %          d3_close
    %          d3_reply
    %          d3_browser
    %          d3_figure
    %          d3_example
    
    %% warnings

    %% function
    
    % figure
    defs.fig.handle =  1;
    defs.fig.title  =  '';
    defs.fig.size.x =  800;
    defs.fig.size.y =  600;
    
    % axis
    defs.axis.rng.x = [nan,nan];        % range
    defs.axis.rng.y = [nan,nan]; 
%     defs.axis.boz.x = false;            % both sides
%     defs.axis.boz.y = false;
%     defs.axis.thk.x = 2;                % thick
%     defs.axis.thk.y = 2;
%     defs.axis.fon.x = 'Arial';          % text font
%     defs.axis.fon.y = 'Arial';
%     defs.axis.lab.x = 'defs.axis.lab.x'; % label
%     defs.axis.lab.y = 'defs.axis.lab.y';
%     defs.axis.tik.x = []; % tick
%     defs.axis.tik.y = []; 
%     defs.axis.til.x = []; % tick label
%     defs.axis.til.y = []; 
    
    % values
    defs.vals.x = [];
    defs.vals.y = [];
    defs.vals.e = [];
    
    % style
    defs.styl.chart = [];
    defs.styl.color = [];
    defs.styl.interp = 'linear';
    
end