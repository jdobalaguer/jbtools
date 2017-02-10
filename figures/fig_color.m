
function color = fig_color(scheme,n)
    %% color = fig_color([scheme])
    % get color schemes (in the range [0,1])
    
    %% function
    
    % default
    if ~exist('scheme', 'var'); scheme = 'parula';  end
    if ~exist('n',      'var'); n      = 5;         end
    
    % numerical scheme
    if isnumeric(scheme)
        assert(isvector(scheme));
        assert(any(size(scheme,2)==[1,3]));
        if length(scheme)==1, scheme = repmat(scheme,1,3); end
        color = repmat(scheme,n,1);
        return;
    end
    
    % prototype scheme
    switch scheme
        % matlab default
        case 'b';       color = repmat(255*[0,0,1],[n,1]);
        case 'g';       color = repmat(255*[0,1,0],[n,1]);
        case 'r';       color = repmat(255*[1,0,0],[n,1]);
        case 'c';       color = repmat(255*[0,1,1],[n,1]);
        case 'm';       color = repmat(255*[1,0,1],[n,1]);
        case 'y';       color = repmat(255*[1,1,0],[n,1]);
        case 'k';       color = repmat(255*[0,0,0],[n,1]);
        case 'w';       color = repmat(255*[1,1,1],[n,1]);
        case 'bw';      color = repmat(170*[1,1,1],[n,1]);
        case 'default'; color = [000,000,255;000,255,000;255,000,000;000,255,255;255,000,255;255,255,000;000,000,000;255,255,255];
        % colours
        case 'gray';    color = zeros(n,3); color(:,1) = linspace(255,0,n);
                                            color(:,2) = linspace(255,0,n);
                                            color(:,3) = linspace(255,0,n);
        case 'red';     color = zeros(n,3); color(:,1) = linspace(255,51,n);
        case 'green';   color = zeros(n,3); color(:,2) = linspace(255,51,n);
        case 'blue';    color = zeros(n,3); color(:,3) = linspace(255,51,n);
        % matlab colormaps
        case 'hot';     f = figure(); color = 255.*hot(n);    close(f);
        case 'cool';    f = figure(); color = 255.*cool(n);   close(f);
        case 'jet';     f = figure(); color = 255.*jet(n);    close(f);
        case 'jet_positive'; color = 255.*fig_color('jet',2*n); color = color(n+(1:n),:);
        case 'jet_negative'; color = 255.*fig_color('jet',2*n); color = color(1:n,:);
        case 'parula';  f = figure(); color = 255.*parula(n); close(f);
        case 'bone';    f = figure(); color = 255.*bone(n);   close(f);
        % palettes (see http://www.colourlovers.com)
        case 'cegato';  color = [029,012,108;237,131,046;233,199,234;061,197,184;215,250,015];
        case 'cucumber';color = [110,009,041;201,215,104;231,247,174;087,080,052;001,201,182];
        case 'forever'; color = [023,198,178;255,183,066;249,118,052;013,086,003;179,077,089];
        case 'summer';  color = [253,242,180;213,233,162;138,191,139;230,166,076;122,035,018];
        case 'bley';    color = [190,252,251;158,184,185;176,165,171;135,118,110;019,018,014];
        case 'work';    color = [214,255,244;214,255,183;252,233,138;175,181,255;155,216,255];
        % palettable
        case 'wong';    color = [148,188,218;144,055,028;071,006,047;143,119,044;216,199,225];
        case 'clovers'; color = [233,127,002;189,021,080;073,010,061;011,072,107;138,155,015;003,054,073];
        % HSV
        case 'hsv';
            color_hsv = nan(n,3);
            color_hsv(:,1) = linspace(1/n,1,n);
            color_hsv(:,2) = 1;
            color_hsv(:,3) = 1;
            color = 255 * hsv2rgb(color_hsv);
        case 'hsv_3';
            color_hsv = nan(n,3);
            color_hsv(:,1) = linspace(1/3/n,1/3,n);
            color_hsv(:,2) = 1;
            color_hsv(:,3) = 1;
            color = 255 * hsv2rgb(color_hsv);
        case 'hsv_4';
            color_hsv = nan(n,3);
            color_hsv(:,1) = linspace(1/4/n,1/4,n);
            color_hsv(:,2) = 1;
            color_hsv(:,3) = 1;
            color = 255 * hsv2rgb(color_hsv);
        case 'hsv_6';
            color_hsv = nan(n,3);
            color_hsv(:,1) = linspace(1/6/n,1/6,n);
            color_hsv(:,2) = 1;
            color_hsv(:,3) = 1;
            color = 255 * hsv2rgb(color_hsv);
    % psychtoolbox
        otherwise
            assert(logical(exist('get_color.m','file')),sprintf('fig_color: scheme "%s" not valid',scheme));
            color = repmat(255*get_color(scheme),[n,1]);
    end
    
    % resize
    s = size(color,1);
    color = repmat(color , ceil(n./s) , 1);
    color(n+1:end , :) = [];
    
    % range [0,1]
    color = color ./ 255;
    
end
