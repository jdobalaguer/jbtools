
function fig_closeall
    %% FIG_CLOSEALL()
    % close all figures. if any resists, kill it.

    %% function
    if ~strcmp(input('Are you sure you want to close all figures? (type "yes") : ','s'),'yes'), return; end
    close('all');
    delete(get(0,'Children'));
end
