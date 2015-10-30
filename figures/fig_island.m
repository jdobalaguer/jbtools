
function h = fig_island()
    %% h = FIG_ISLAND()
    % create a figure without decoration
    
    %% notes
    % from http://undocumentedmatlab.com/blog/frameless-undecorated-figure-windows#more-5642
    
    %% function
    % Create a simple Matlab figure (visible, but outside monitor area)
    hFig = figure('Name','Plot example', 'ToolBar','none', 'MenuBar','none');

    % Ensure that everything is rendered, otherwise the following will fail
    drawnow;

    % Get the underlying Java JFrame reference handle
    evalc('mjf = get(handle(hFig), ''JavaFrame'');');
    jWindow = mjf.fHG2Client.getWindow;

    % Get the content pane's handle
    mjc = jWindow.getContentPane;
    mjr = jWindow.getRootPane;  % used for the offset below

    % Create a new pure-Java undecorated JFrame
    figTitle = jWindow.getTitle;
    jDesktop = com.mathworks.mde.desk.MLDesktop.getInstance;
    jFrame = javaObjectEDT(com.mathworks.widgets.desk.DTSingleClientFrame(jDesktop, figTitle));
    jFrame.setUndecorated(true);

    % Move the JFrame's on-screen location just on top of the original
    jFrame.setLocation(mjc.getLocationOnScreen);

    % Set the JFrame's size to the Matlab figure's content size
    jFrame.setSize(mjc.getWidth+mjr.getX, mjc.getHeight+mjr.getY);

    % Reparent (move) the contents from the Matlab JFrame to the new JFrame
    jFrame.setContentPane(mjc);

    % Make the new JFrame visible
    jFrame.setVisible(true);

    % Hide the Matlab figure by moving it off-screen
    pos = get(hFig,'Position');
    set(hFig, 'Position',[-1000,-1000,pos(3:4)]);
    drawnow;
    
    % close callback
    hjWindow = handle(jWindow, 'CallbackProperties');
    set(hjWindow, 'FocusGainedCallback', @(h,e)jFrame.requestFocus);
    set(hjWindow, 'WindowClosedCallback', @(h,e)jFrame.dispose);
    
    % return
    h = hFig;
end
