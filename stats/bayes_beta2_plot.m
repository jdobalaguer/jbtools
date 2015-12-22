
function bayes_beta2_plot(pars1,pars2)
    %% BAYES_BETA2_PLOT(pars1,pars2)
    % auxiliar function
    
    %% function
    n = 500;
    
    % get Beta PDF
    beta = bayes_pdf_beta(pars1,pars2);
    
    % get values
    z = linspace(0,1,n);
    [z1,z2] = ndgrid(z,z);
    pdf = beta(z1,z2);
    pdf = reshape(pdf,[n,n]);
    
    % plot
    fig_figure();
    [c,h] = contourf(z,z,pdf'); clabel(c,h);
    fig_axis(struct('xlabel',{'\theta_1'},'ylabel',{'\theta_2'},'xtick',{[]},'ytick',{[]}));
    axis('square'); fig_fontsize();
end
