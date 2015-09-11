
function h = aux_ds(obj,slice,parent)
    %% h = AUX_DS(obj,slice,parent)
    % display the statistics
    
    %% function
    disp('aux_dS');
    
    % grid
    z = zeros(mat_size(slice,[1,2]));
    c = slice;
    
    % plot
    h = surface(z,c,'Parent',parent,'LineStyle','none','EdgeColor','none');
end
