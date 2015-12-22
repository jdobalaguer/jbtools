
function varargout = bayes_beta1_rope(x,varargin)
    %% [h,p,stats] = BAYES_BETA1_ROPE(x[,'param1',val1][,..])
    % For a single bernouilli random variable, calculate the probability
    % of accepting a null hypothesis, given a binary vector [x],
    % as belonging to a certain ROPE.
    % If no output, the result is plotted and printed.
    %
    % The default alpha is 0.05
    % The default prior is a Beta(1,1)
    % The default ROPE is for the interval [0.475,0.525]
    %
    % List of outputs
    %   h         : null hypothesis rejected (logical)
    %   p         : p-value of null hypothesis
    %   stats     : statistics
    %
    % List of parameters
    %   'alpha'   : probability of rejecting the null hypothesis
    %   'prior'   : vector containing [a,b] parameters for the prior
    %   'rope'    : region of practical equivalence
    % 
    % See also bayes
    
    %% function
    varargout = {};
    
    % default
    dflt = struct('alpha',{0.05},'prior',{[1,1]},'rope',{[0.475,0.525]});
    pars = pair2struct(varargin{:});
    pars = struct_default(pars,dflt);
    
    % prior, likelihood and posterior
    prior = pars.prior;
    likelihood = [sum(logical(x)),sum(logical(~x))];
    posterior  = prior + likelihood;
    
    % test
    p = 1-abs(betacdf(pars.rope(1),posterior(1),posterior(2)) - betacdf(pars.rope(2),posterior(1),posterior(2)));
    h = (p < pars.alpha);
    stats = struct('h',{h},'p',{p});
    stats.prior      = prior;
    stats.likelihood = likelihood;
    stats.posterior  = posterior;
    
    % output
    if nargout, varargout = {h,p,stats}; return; end
    
    % plot & print
    bayes_beta1_plot(pars,stats);
    print_results(stats,'accept the ROPE');
end
