
function fig_closeall
    %% FIG_CLOSEALL()
    % close all figures. if any resists, kill it.

    %% function
    close('all');
    delete(get(0,'Children'));
end