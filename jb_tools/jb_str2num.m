

function y = jb_str2num(x)
    y = nan(size(x));
    for i = 1:length(x)
        y(i) = str2num(x{i});
    end
end