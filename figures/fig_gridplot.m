
function h = fig_gridplot(m,n,i,j)
    %% h = FIG_GRIDPLOT(m,n,i,j)
    % like subplot, but with two indices
    
    %% function
    switch nargin
        case 3, ij = i;
        case 4, ij = (i-1)*n + j;
    end
    h  = subplot(m,n,ij);
    hold('on');
end
