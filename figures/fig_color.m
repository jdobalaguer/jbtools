
function color = fig_color(scheme)
    %% color = fig_color([scheme])
    %
    % get color schemes
    %
    
    %% default
    if ~exist('scheme','var'); scheme = 'default'; end
    
    %% scheme
    switch scheme
        % matlab default
        case 'b';       color = 255*[0,0,1];
        case 'g';       color = 255*[0,1,0];
        case 'r';       color = 255*[1,0,0];
        case 'c';       color = 255*[0,1,1];
        case 'm';       color = 255*[1,0,1];
        case 'y';       color = 255*[1,1,0];
        case 'k';       color = 255*[0,0,0];
        case 'w';       color = 255*[1,1,1];
        case 'default'; color = 255*[0,0,1;0,1,0;1,0,0;0,1,1;1,0,1;1,1,0;0,0,0;1,1,1];
        % colours
        case 'white';   color = repmat([255,255,255],[5,1]);
        case 'gray';    color = repmat([200,200,200],[5,1]);
        case 'black';   color = repmat([  0,  0,  0],[5,1]);
        case 'red';     color = zeros(5,3); color(:,1) = linspace(255,51,5);
        case 'green';   color = zeros(5,3); color(:,2) = linspace(255,51,5);
        case 'blue';    color = zeros(5,3); color(:,3) = linspace(255,51,5);
        % matlab colormaps
        case 'hot';     f = figure(); color = 255.*hot(); close(f);
        case 'cool';    f = figure(); color = 255.*cool(); close(f);
        case 'jet';     f = figure(); color = 255.*jet(); close(f);
        % palettes (see http://www.colourlovers.com)
        case 'cegato';  color = [29,12,108;237,131,46;233,199,234;61,197,184;215,250,15];
        case 'cucumber';color = [110,9,41;201,215,104;231,247,174;87,80,52;1,201,182];
        case 'forever'; color = [23,198,178;255,183,66;249,118,52;13,86,3;179,77,89];
        case 'summer';  color = [253,242,180;213,233,162;138,191,139;230,166,76;122,35,18];
        case 'bley';    color = [190,252,251;158,184,185;176,165,171;135,118,110;19,18,14];
        case 'work';    color = [214,255,244;214,255,183;252,233,138;175,181,255;155,216,255];
        otherwise       error('fig_color: scheme "%s" not valid',scheme);
    end
end
