
function [m,e] = getm_me(varargin)
    % [m,e] = GETM_ME(y,s,x1[,x2][,x3][...])
    
    z = getm_mean(varargin{:});
    m = meeze(z,1);
    e = steeze(z,1);
end