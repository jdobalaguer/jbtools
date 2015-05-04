
function scan = scan_plot_peristimulus(varargin)
    %% SCAN_PLOT_PERISTIMULUS(LEVEL,SCAN)
    % SCAN_PLOT_PERISTIMULUS(LEVEL,PATH_TO_GLM,MASK,CONTRASTS)
    % Plot peristimulus BOLD signal
    % (after running scan_glm_run() with scan.glm.function = 'fir')
    % level can be 'first', 'beta', or 'second'
    
    %% WARNINGS
    %#ok<*ERTAG,*FPARK>
    
    %% FUNCTION
    
    % parse and load
    if isstr(varargin{2}) && nargin==4,
        assert(exist([varargin{2},'/scan.mat'],'file')>0, 'scan_plot_peristimulus: error. no "scan.mat" file found');
        load([varargin{2},'/scan.mat']);
        scan.glm.plot.mask       = varargin{3};
        scan.glm.plot.contrast   = varargin{4};
        scan.dire.glm.root       = varargin{2};
        scan.dire.glm.beta1      = [scan.dire.glm.root,'copy/beta_1/'];
        scan.dire.glm.beta2      = [scan.dire.glm.root,'copy/beta_2/'];
        scan.dire.glm.contrast1  = [scan.dire.glm.root,'copy/contrast_1/'];
        scan.dire.glm.contrast2  = [scan.dire.glm.root,'copy/contrast_2/'];
        scan.dire.glm.statistic1 = [scan.dire.glm.root,'copy/statistic_1/'];
        scan.dire.glm.statistic2 = [scan.dire.glm.root,'copy/statistic_2/'];
        scan.dire.mask           = [pwd(),'/data/mask/'];
    elseif isstruct(varargin{2}) && nargin==2
        scan = varargin{2};
    else
        error('scan_plot_peristimulus: error. wrong input');
    end
    if ~iscell(scan.glm.plot.contrast), scan.glm.plot.contrast = {scan.glm.plot.contrast}; end

    % multiplexer
    switch varargin{1}
        case 'beta_1'
            scan_plot_peristimulus_1(scan, scan.dire.glm.beta1);
        case 'cont_1'
            scan_plot_peristimulus_1(scan, scan.dire.glm.contrast1);
        case 'spmt_1'
            scan_plot_peristimulus_1(scan, scan.dire.glm.statistic1);
        case 'beta_2'
            scan_plot_peristimulus_2(scan, scan.dire.glm.beta2);
        case 'cont_2'
            scan_plot_peristimulus_2(scan, scan.dire.glm.contrast2);
        case 'spmt_2'
            scan_plot_peristimulus_2(scan, scan.dire.glm.statistic2);
        otherwise
            assert(ischar(varargin{1}),'scan_plot_peristimulus: error. level is not a string')
            error('scan_plot_peristimulus: error. level "%s" not recognised',varargin{1});
    end
end
