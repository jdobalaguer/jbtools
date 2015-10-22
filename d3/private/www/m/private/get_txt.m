% get txt files
function html = get_txt(filename)
    filename = fullfile(d3_root(),'private','www','txt',filename);
    html = fileread(filename);
end
