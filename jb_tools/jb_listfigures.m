
function h = jb_listfigures()
    %% h = jb_listfigures()
    % return a list of all figure handles
    
    h = get(0,'Children');
end