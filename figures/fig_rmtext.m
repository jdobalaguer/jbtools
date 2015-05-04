
function fig_rmtext(h)
    %% FIG_RMTEXT([h])
    % remove all text from figure
    
    %% warnings
    %#ok<*LAXES>
    
    %% function
    default('h',gcf());
    removeText(h);
    removeAxes(h);
end

%% auxiliar
function removeText(h)
    if strcmpi(get(h,'Type'),'text')
        delete(h);
    else
        c = get(h,'Children');
        for i = 1:length(c)
            removeText(c(i));
        end
    end
end

function removeAxes(h)
    a = get(h,'Children');
    for i = 1:length(a)
        axes(a(i));
        sa.title = '';
        sa.xlabel = '';
        sa.ylabel = '';
        sa.xticklabel = {''};
        sa.yticklabel = {''};
        fig_axis(sa);
        set(gca(),'XMinorTick','off');
        set(gca(),'YMinorTick','off');
    end
end
