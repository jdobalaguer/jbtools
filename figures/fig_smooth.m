    

function fig_smooth(cf)
    %% fig_smooth(cf)
    % 
    % smooth all lines in figure [cf]
    % 

    %% default
    if ~exist('cf','var')||isempty(cf); cf=gcf(); end
    
    %% smooth
    opengl('OpenGLLineSmoothingBug',1);
    children_smooth(cf);

end

function children_smooth(hdls)
    for hdl = allchild(hdls)' %1:allchild(hdls)
        if ishandle(hdl)
            g = get(hdl);
            if isfield(g,'LineSmoothing');  set(hdl,'LineSmoothing','on'); end
        end
    end
end
