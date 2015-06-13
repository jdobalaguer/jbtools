
function plot_args = scan_function_plot_args()
    %% plot_args = SCAN_FUNCTION_PLOT_ARGS()
    % default arguments for plot
    % to list main functions, try
    %   >> help scan;
    
    %% funtion
    plot_args.figure       = [];
    plot_args.color_stroke = [0,     0,    1   ];
    plot_args.color_fill   = [0.83 , 0.83, 0.83];
    plot_args.color_scheme = 'parula';
    plot_args.fontname     = 'Calibri';
    plot_args.fontsize     = 16;
    plot_args.max_ticks    = 20;
    
end