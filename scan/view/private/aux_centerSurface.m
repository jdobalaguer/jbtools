
function [xdata,ydata,zdata,cdata] = aux_centerSurface(xdata,ydata,zdata,cdata)
    %% [xdata,ydata,zdata,cdata] = AUX_CENTERSURFACE(xdata,ydata,zdata,cdata)
    
    %% function

    % x values
    d_xdata = diff(xdata,[],1);
    d_xdata(end+1,:) = +d_xdata(end,:);
    d_xdata(end+1,:) = -d_xdata(end,:);
    xdata(end+1,:) = xdata(end,:);
    xdata = xdata - 0.5 * d_xdata;
    xdata(:,end+1) = xdata(:,end);

    % y values
    d_ydata = diff(ydata,[],2);
    d_ydata(:,end+1) = +d_ydata(:,end);
    d_ydata(:,end+1) = -d_ydata(:,end);
    ydata(:,end+1) = ydata(:,end);
    ydata = ydata - 0.5 * d_ydata;
    ydata(end+1,:) = ydata(end,:);

    % z values
    zdata(:,end+1) = 0;
    zdata(end+1,:) = 0;
    
    % colour values
    cdata(:,end+1) = nan;
    cdata(end+1,:) = nan;
end