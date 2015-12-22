
function bayes_beta1_plot(pars,stats)
    %% BAYES_BETA1_PLOT(pars,stats)
    % auxiliar function
    
    %% function
    n = 500;
    
    fig_figure();
    
    % prior, likelihood, posterior
    z              = linspace(0,1,n);
    pdf_prior      = betapdf(z,stats.prior(1),stats.prior(2));
    pdf_likelihood = betapdf(z,stats.likelihood(1),stats.likelihood(2));
    pdf_posterior  = betapdf(z,stats.posterior(1),stats.posterior(2));
    h_prior        = plot(z,pdf_prior,'LineStyle','-','LineWidth',3);
    h_likelihood   = plot(z,pdf_likelihood,'LineStyle','-','LineWidth',3);
    h_posterior    = plot(z,pdf_posterior,'LineStyle','-','LineWidth',3);
    va = fig_axis(struct('ilegend',{[h_prior,h_likelihood,h_posterior]},'tlegend',{{'prior','likelihood','posterior'}}));
    set(va.hlegend,'Location','Best');
    
    % high-density interval (HDI)
    if struct_isfield(stats,'hdi')
        z  = linspace(stats.hdi(1),stats.hdi(2),n);
        zz = [z,fliplr(z)];
        pdf_hdi  = betapdf(z,stats.posterior(1),stats.posterior(2));
        hh = [pdf_hdi,zeros(size(pdf_hdi))];
        c = get(h_posterior,'Color');
        fill(zz,hh,c,'EdgeColor',c,'LineStyle','--','LineWidth',1,'FaceAlpha',0.15);
    end

    % threshold (null)
    if struct_isfield(pars,'thresh')
        plot([pars.thresh,pars.thresh],ylim(),'Color','k','LineStyle','--','LineWidth',1);
    end
    
    % ROPE (null)
    if struct_isfield(pars,'rope')
        zz = [pars.rope,fliplr(pars.rope)];
        hh = ylim();
        hh = [hh(1),hh(1),hh(2),hh(2)];
        fill(zz,hh,[0.666,0.666,0.666],'EdgeColor',[0,0,0],'LineStyle','--','LineWidth',1,'FaceAlpha',0.15);
    end
end
