
function h = fig_boxplot(x,y,c)
    %% h = FIG_BOXPLOT([x,]y,c)
    % Create bars with standard errors
    % the error bar goes 1e up and 1e down

    %% function
    
    % variables
    try
        func_default('x',mat2row(1:(numel(y)/size(y,1))) ...
                        + mat2row(meshgrid(1:mat_size(y,3:ndims(y)),1:size(y,2))) ...
                        - 1);
    end
    func_default('x',1:size(y,2));
    func_default('c',[0,0,0]);
    
    % plot
    h = boxplot(y(:,:),'positions',x,'whisker',inf);
    set(h,'Color',c);
    
    % horizontal axis
    plot(ranger(x)+[-1,+1],[0,0],'Color','black','LineStyle','--','LineWidth',2);
    
    % invisible zeros
    all(~y(:,:),1)
    set(h(:,all(~y(:,:),1)),'Visible','off');
end
