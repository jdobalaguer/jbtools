function c = jb_cellcat(varargin)
    assert(~isempty(varargin),'scan_mvpa: cellcat: error. empty varargin');
    c = cell(1,nargin);
    for i = 1:length(varargin)
        x = varargin{i};
        if (iscell(x) && length(x)==1); x = x{1}; end
        c{i} = x;
    end
end
