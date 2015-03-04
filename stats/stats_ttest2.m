
function stats_ttest2(x,y)
    %%  
    
    %% warnings
    
    %% function
    switch nargin
        case 1, z = x;
        case 2, z = x-y;
    end
    
    fig_figure();
    subplot(1,2,1);
    hist(z,-3:0.5:+3);
    
    subplot(1,2,2);
    z = repmat(z,sizep(z,[2,1]));
    z = 0.5 * (z + z');
    hist(z(:),-3:0.5:+3);

end