
function d3_help()
    %% D3_HELP()
    % d3 is a toolbox to display data through web-browser, using 
    % external libraries like d3.js or three.js
    %
    % the matlab functions d3_ are not a web service. they create a
    % temporal webserver that displays the necessary HTML/javascript
    % code to plot your data, and then turns off. it doesn't create
    % multiple processes and doesn't require any additional matlab
    % toolboxes either. it only requires having a browser installed that
    % supports for HTML5.
    %
    % if you want to see an example, try to run
    % >> d3_example();
    %
    % function d3_figure() will display your data in a new browser page
    % however, it takes inputs in a very specific format.
    % function d3_data() is meant to format your data in the way that is
    % required by d3_figure().
    %
    % kinds of charts:
    %   + plot
    %   + grid2D
    %
    % see also d3_data.m
    %          d3_figure.m
    %          d3_example.m

    
    
    %% warnings
    
    %% function
    help('d3_help');
end