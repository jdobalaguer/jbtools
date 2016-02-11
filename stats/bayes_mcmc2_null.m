
function varargout = bayes_mcmc2_null(prior,likelihood,varargin)
    %% [h,p,stats] = BAYES_MCMC_NULL(prior,likelihood[,'param1',val1][,..])
    % Calculate the probability that of rejecting a null hypothesis for the
    % difference between two parameters, given a prior and likelihood functions.
    % If no output, the result is plotted and printed.
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
    %   'index'    : parameters under the test (default [1,2])
    %   'alpha'    : probability of rejecting the null hypothesis (default 0.05)
    %   'tail'     : one of {'left','right','both'} (default 'both')
    %   'thresh'   : value of theta to be rejected (default 0.5)
    %
    % List of MCMC parameters
    %   'method'        : the method for MCMC, one of {'slicesample','mhsample'}
    %   'mcmc_initial'  : initial position for the MCMC random walk
    %   'mcmc_nsamples' : number of samples obtained (default 1e4)
    %   'mcmc_burnin'   : burnin period, a scalar > 0
    %   'mcmc_thin'     : ???
    %   Other parameters may be added depending on the MCMC method used.
    %   They need to be defined as 'mcmc_*'.
    % 
    % See also bayes
    
    %% function
    varargout = {};
    
    % default
    dflt = struct('index',{[1,2]},'alpha',{0.05},'tail',{'both'},'thresh',{0.5},...
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
    sample = samples(:,pars.index(1)) - samples(:,pars.index(2));
    switch pars.tail
        case 'left'
            p = mean(sample > pars.thresh);
            hdi = [-inf,quantile(samples,1-pars.alpha)];
        case 'right'
            p = mean(sample < pars.thresh);
            hdi = [quantile(sample,pars.alpha),+inf];
        case 'both'
            p = mean(sample < pars.thresh);
            p = 2 * min(p,1-p);
            hdi = [quantile(sample,0.5*pars.alpha),quantile(sample,1-0.5*pars.alpha)];
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
    bayes_mcmc2_plot(pars,stats);
    print_results(stats,'reject the null hypothesis');
end