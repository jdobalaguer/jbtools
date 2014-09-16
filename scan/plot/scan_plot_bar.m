
function scan_plot_bar(varargin)
    %% SCAN_PLOT_BAR(LEVEL,SCAN)
    % SCAN_PLOT_BAR(LEVEL,PATH_TO_GLM,MASK,CONTRASTS)
    % Plot bars BOLD signal
    % (after running scan_glm_run() with scan.glm.function = 'fir')
    % level can be 'first', 'beta', or 'second'
    
    %% WARNINGS
    %#ok<*ERTAG,*FPARK>

    %% FUNCTION
    
    % parse & load
    if isstr(varargin{2}) && nargin==4,
        assert(exist([varargin{2},'/scan.mat'],'file')>0, 'scan_plot_bar_b1: error. no "scan.mat" file found');
        load([varargin{2},'/scan.mat']);
        scan.glm.plot.mask     = varargin{3};
        scan.glm.plot.contrast = varargin{4};
    elseif isstruct(varargin{2}) && nargin==2
        scan = varargin{2};
    else
        error('scan_plot_bar: error. wrong input');
    end
    
    % assert
    assert(isfield(scan.glm.plot,'mask'), 'scan_plot_bar: error. no mask specified');
    assert(~isempty(scan.glm.plot.mask),  'scan_plot_bar: error. no mask specified');
    
    % multiplexer
    switch varargin{1}
        case 'beta_1'
            scan_plot_bar_1(scan,scan.dire.glm.beta1);
        case 'cont_1'
            scan_plot_bar_1(scan,scan.dire.glm.contrast1);
        case 'spmt_1'
            scan_plot_bar_1(scan,scan.dire.glm.statistic1);
        case 'beta_2'
            scan_plot_bar_2(scan,scan.dire.glm.beta2);
        case 'cont_2'
            scan_plot_bar_2(scan,scan.dire.glm.contrast2);
        case 'spmt_2'
            scan_plot_bar_2(scan,scan.dire.glm.statistic2);
        otherwise
            assert(ischar(varargin{1}),'scan_plot_bar: error. level is not a string')
            error('scan_plot_bar: error. level "%s" not recognised',varargin{1});
    end
end
