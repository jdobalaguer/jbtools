
function h = fig_gridplot(m,n,i,j)
    %% h = FIG_GRIDPLOT(m,n,i,j)
    % like subplot, but with two indices
    
    %% function
    ij = (i-1)*n + j;
    h  = subplot(m,n,ij);
    hold('on');
end
