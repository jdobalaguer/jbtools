
% get m files
function html = get_m(varargin)
    filename = fullfile(d3_root(),'private','www','m',varargin{1});
    html = func_run(filename,varargin(2:end));
end
