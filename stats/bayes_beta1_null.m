
function varargout = bayes_beta1_null(x,varargin)
    %% [h,p,stats] = BAYES_BETA1_NULL(x[,'param1',val1][,..])
    % For a single bernouilli random variable, calculate the probability
    % of rejecting a null hypothesis, given a binary vector [x].
    % If no output, the result is plotted and printed.
    %
    % The default alpha is 0.05
    % The default prior is a Beta(1,1)
    % The default null-hypothesis is for the value 0.5
    % The default null-hypothesis is two-tailed.
    %
    % List of outputs
    %   h         : null hypothesis rejected (logical)
    %   p         : p-value of null hypothesis
    %   stats     : statistics
    %
    % List of parameters
    %   'alpha'   : probability of rejecting the null hypothesis
    %   'prior'   : vector containing [a,b] parameters for the prior
    %   'tail'    : one of {'left','right','both'} (default 'both')
    %   'thresh'  : value of theta to be rejected (default 0.5)
    % 
    % See also bayes
    
    %% function
    varargout = {};
    
    % default
    dflt = struct('alpha',{0.05},'prior',{[1,1]},'tail',{'both'},'thresh',{0.5});
    pars = pair2struct(varargin{:});
    pars = struct_default(pars,dflt);
    
    % prior, likelihood and posterior
    prior = pars.prior;
    likelihood = [sum(logical(x)),sum(logical(~x))];
    posterior  = prior + likelihood;
    
    % test
    switch pars.tail
        case 'left'
            p = 1-betacdf(pars.thresh,posterior(1),posterior(2));
            hdi = [0,betainv(1-pars.alpha,posterior(1),posterior(2))];
        case 'right'
            p = betacdf(pars.thresh,posterior(1),posterior(2));
            hdi = [betainv(pars.alpha,posterior(1),posterior(2)),1];
        case 'both'
            p = 2 * min(betacdf(pars.thresh,posterior(1),posterior(2)),1-betacdf(pars.thresh,posterior(1),posterior(2)));
            hdi = betainv([.5*pars.alpha,1-.5*pars.alpha],posterior(1),posterior(2));
        otherwise,    error('stats_bayes_beta: error. [tail] is not valid.');
    end
    h = (p < pars.alpha);
    stats = struct('h',{h},'p',{p});
    stats.prior      = prior;
    stats.likelihood = likelihood + 1;
    stats.posterior  = posterior;
    stats.hdi        = hdi;
    
    % output
    if nargout, varargout = {h,p,stats}; return; end
    
    % plot & print
    bayes_beta1_plot(pars,stats);
    print_results(stats,'reject the null hypothesis');
end
