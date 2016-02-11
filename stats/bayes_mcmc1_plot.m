
function bayes_mcmc1_plot(pars,stats)
    %% BAYES_MCMC1_PLOT(pars,stats)
    % auxiliar function
    
    %% function
    n = 500;
    
    fig_figure();
    
    % prior, likelihood, posterior
    z              = linspace(min(stats.samples(:,pars.index)),max(stats.samples(:,pars.index)),n);
    pdf_prior      = stats.pdf.prior(z);
    pdf_likelihood = stats.pdf.likelihood(z);
    pdf_posterior  = bayes_pdf(stats.samples,z);
    h_prior        = plot(z,pdf_prior,'LineStyle','-','LineWidth',3);
    h_likelihood   = plot(z,pdf_likelihood,'LineStyle','-','LineWidth',3);
    h_posterior    = plot(z,pdf_posterior,'LineStyle','-','LineWidth',3);
    va = fig_axis(struct('ilegend',{[h_prior,h_likelihood,h_posterior]},'tlegend',{{'prior','likelihood','posterior'}},'xlim',{ranger(stats.samples)}));
    set(va.hlegend,'Location','Best');
    
    % high-density interval (HDI)
    if struct_isfield(stats,'hdi')
        hdi = stats.hdi;
        switch pars.tail
            case 'left',  hdi(1) = min(stats.samples(:,pars.index));
            case 'right', hdi(2) = max(stats.samples(:,pars.index));
        end
        z_hdi   = linspace(hdi(1),hdi(2),n);
        pdf_hdi = nan2zero(interp1(z,pdf_posterior,z_hdi));
        zz = [z_hdi,fliplr(z_hdi)];
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
