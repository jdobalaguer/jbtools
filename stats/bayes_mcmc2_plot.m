
function bayes_mcmc2_plot(varargin)
    %% BAYES_MCMC2_PLOT(pdf)
    % BAYES_BETA2_PLOT(pars1,pars2)
    % auxiliar function
    % pdf  : a function handle of the form @(z1,z2)
    % pars : a vector of the form [a,b]
    
    %% function
    error('TODO');
    n = 500;
    
    % get Beta PDF
    switch nargin
        case 1, beta = varargin{1};
        case 2, beta = bayes_pdf_beta(varargin{1:2});
        otherwise error('bayes_beta2_plot: eroor. too many input arguments');
    end
    
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
