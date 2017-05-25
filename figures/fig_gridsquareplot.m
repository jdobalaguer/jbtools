
function h = fig_gridsquareplot(n,i)
    %% h = FIG_GRIDSQUAREPLOT(n,i)
    % like subplot, but only the numel is required
    
    %% function
    b = round(sqrt(n*16/9));
    a = ceil(b*9/16);
    h  = subplot(a,b,i);
    hold('on');
end
