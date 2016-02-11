
function fig_rmtext(h)
    %% FIG_RMTEXT([h])
    % remove all text from figure
    
    %% warnings
    %#ok<*LAXES>
    
    %% function
    func_default('h',gcf());
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
            try removeText(c(i)); end
        end
    end
end

function removeAxes(h)
    a = get(h,'Children');
    for i = 1:length(a)
        try
            axes(a(i));
            sa.title = '';
            sa.xlabel = '';
            sa.ylabel = '';
            sa.xticklabel = {''};
            sa.yticklabel = {''};
            sa.xminor = 'off';
            sa.yminor = 'off';
            fig_axis(sa);
        end
    end
end
