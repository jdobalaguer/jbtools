
function fig_smooth(cf)
    %% fig_smooth(cf)
    % smooth all lines in figure [cf]

    %% function
    
    % default
    func_default('cf',gcf());
    
    % smooth
    opengl('OpenGLLineSmoothingBug',1);
    children_smooth(cf);
end

%% auxiliar
function children_smooth(hdls)
    for hdl = allchild(hdls)'
        if ishandle(hdl)
            g = get(hdl);
            if isfield(g,'LineSmoothing');  set(hdl,'LineSmoothing','on'); end
        end
    end
end
