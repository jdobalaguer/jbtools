
function varargout = bayes_mcmc1_null(prior,likelihood,varargin)
    %% [h,p,stats] = BAYES_MCMC1_NULL(prior,likelihood[,'param1',val1][,..])
    % Calculate the probability that of rejecting a null hypothesis, given
    % a binary vector [x]. If no output, the result is plotted and printed.
    %
    % The default alpha is 0.05
    %
    % List of inputs
    %   prior      : a function @(z) describing the prior distribution
    %   likelihood : a function @(z) describing the likelihood p(d|z)
    %
    % List of outputs
    %   h          : null hypothesis rejected (logical)
    %   p          : bayes factor
    %   stats      : statistics
    %
    % List of hypothesis parameters
    %   'alpha'    : probability of rejecting the null hypothesis
    %   'tail'     : one of {'left','right','both'} (default 'both')
    %   'thresh'   : value of theta to be rejected (default 0.5)
    %
    % List of MCMC parameters
    %   'method'        : the method for MCMC, one of {'slicesample','mhsample'}
    %   'mcmc_initial'  : initial position for the MCMC random walk
    %   'mcmc_nsamples' : number of samples obtained (default 1e4)
    %   'mcmc_burnin'   : burnin period, a scalar > 0
    %   'mcmc_thin'     : ???
    %   Other parameters can be added depending on the MCMC method used.
    %   They need to be defined as 'mcmc_*'
    % 
    % See also bayes
    
    %% function
    varargout = {};
    
    % default
    dflt = struct('alpha',{0.05},'tail',{'both'},'thresh',{0.5},...
                  'method',{'slicesample'},'mcmc',{struct('initial',{0},'nsamples',{1e4})});
    pars = pair2struct(varargin{:});
    pars = struct_deep(pars);
    pars = struct_default(pars,dflt);
    
    % markov-chain monte-carlo
    posterior = @(z) prior(z) .* likelihood(z);
    mcmc      = struct_rm(pars.mcmc,'initial','nsamples');
    mcmc.pdf  = posterior;
    mcmc      = struct2pair(mcmc);
    samples   = slicesample(pars.mcmc.initial,pars.mcmc.nsamples,mcmc{:});
    
    % test
    switch pars.tail
        case 'left',
            p = mean(samples > pars.thresh);
            hdi = [-inf,quantile(samples,1-pars.alpha)];
        case 'right',
            p = mean(samples < pars.thresh);
            hdi = [quantile(samples,pars.alpha),+inf];
        case 'both',
            p = mean(samples < pars.thresh);
            p = 2 * min(p,1-p);
            hdi = [quantile(samples,0.5*pars.alpha),quantile(samples,1-0.5*pars.alpha)];
        otherwise,    error('stats_bayes_beta: error. [tail] is not valid.');
    end
    h = (p < pars.alpha);
    stats = struct('h',{h},'p',{p});
    stats.pdf.prior      = prior;
    stats.pdf.likelihood = likelihood;
    stats.pdf.posterior  = posterior;
    stats.samples        = samples;
    stats.hdi            = hdi;
    
    % output
    if nargout, varargout = {h,p,stats}; return; end
    
    % plot & print
    bayes_mcmc1_plot(pars,stats);
    print_results(stats,'reject the null hypothesis');
end