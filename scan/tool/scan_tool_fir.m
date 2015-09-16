
function scan_tool_fir(scan,mask,condition,color)
    %% SCAN_TOOL_FIR(scan,mask[,condition][,order][,color])
    % plot multiple FIR estimates
    % mask      : path to the region of interest (relative to scan.directory.mask)
    % condition : cell of strings with the conditions to plot (default all conditions)
    % color     : matrix of size [n,3] with the RGB color on rows matching each condition
    %             or a string with the colormap (default "hsv")

    %% function
    
    % default
    func_default('condition',cell_flat(mat2vec({scan.job.condition.name;scan.job.condition.subname})));
    if ischar(condition), condition = {condition}; end
    func_default('color','hsv');
    
    % numbers
    u_condition = condition;
    n_condition = length(u_condition);
    if ischar(color), u_color = fig_color(color,n_condition);
    else              u_color = color;
    end
    
    % plot
    fw = func_wait(n_condition);
    h = fig_figure();
    for i_condition = 1:n_condition
        scan.function.plot.fir(scan,'first','beta',mask,u_condition{i_condition},'figure',h,'color_stroke',u_color(i_condition,:));
        func_wait([],fw);
    end
    func_wait(0,fw);
    
    % axis
    c = get(get(h,'Children'),'Children');
    sa.title      = strrep(file_2local(mask),'_',' ');
    sa.ytick      = {};
    sa.yticklabel = {};
    sa.xtick      = 1:scan.job.basisFunction.parameters.order;
    sa.xticklabel = linspace(0,scan.job.basisFunction.parameters.length,scan.job.basisFunction.parameters.order);
    sa.ilegend = c(strcmp(get(c,'Type'),'patch'));
    sa.tlegend = strrep(file_2local(u_condition),'_',' ');
    fig_axis(sa);
    
    set(gca,'YColor','w');

end
