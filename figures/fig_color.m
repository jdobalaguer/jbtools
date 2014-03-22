
function color = fig_color(scheme,n)
    %% color = fig_color([scheme])
    %
    % get color schemes
    %
    
    %% default
    if ~exist('scheme', 'var'); scheme = 'default'; end
    if ~exist('n',      'var'); n      = 5;         end
    
    %% scheme
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
        case 'default'; color = 255*[0,0,1;0,1,0;1,0,0;0,1,1;1,0,1;1,1,0;0,0,0;1,1,1];
        % colours
        case 'gray';    color = zeros(n,3); color(:,1) = linspace(255,0,n);
                                            color(:,2) = linspace(255,0,n);
                                            color(:,3) = linspace(255,0,n);
        case 'red';     color = zeros(n,3); color(:,1) = linspace(255,51,n);
        case 'green';   color = zeros(n,3); color(:,2) = linspace(255,51,n);
        case 'blue';    color = zeros(n,3); color(:,3) = linspace(255,51,n);
        % matlab colormaps
        case 'hot';     f = figure(); color = 255.*hot(n);  close(f);
        case 'cool';    f = figure(); color = 255.*cool(n); close(f);
        case 'jet';     f = figure(); color = 255.*jet(n);  close(f);
        % palettes (see http://www.colourlovers.com)
        case 'cegato';  color = [29,12,108;237,131,46;233,199,234;61,197,184;215,250,15];
        case 'cucumber';color = [110,9,41;201,215,104;231,247,174;87,80,52;1,201,182];
        case 'forever'; color = [23,198,178;255,183,66;249,118,52;13,86,3;179,77,89];
        case 'summer';  color = [253,242,180;213,233,162;138,191,139;230,166,76;122,35,18];
        case 'bley';    color = [190,252,251;158,184,185;176,165,171;135,118,110;19,18,14];
        case 'work';    color = [214,255,244;214,255,183;252,233,138;175,181,255;155,216,255];
        % HSV
        case 'hsv';
            color_hsv = nan(n,3);
            color_hsv(:,1) = linspace(1/n,1,n);
            color_hsv(:,2) = 1;
            color_hsv(:,3) = 1;
            color = 255 * hsv2rgb(color_hsv);
    % otherwise
        otherwise       error('fig_color: scheme "%s" not valid',scheme);
    end
    
    if size(color,1)~=n
        fprintf('fig_color: warning. scheme "%s" has %d colors \n',scheme,size(color,1));
    end
end
