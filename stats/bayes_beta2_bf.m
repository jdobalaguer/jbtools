
function varargout = bayes_beta2_bf(x,y,varargin)
    %% [h,bf,stats] = BAYES_BETA2_BF(x,y[,'param1',val1][,..])
    % For two bernouilli random variables, calculate the probability
    % that the biases are equal, given two binary vectors [x] and [y].
    % If no output, the result is printed.
    %
    % The default alpha is 0.05
    % The default prior is a Beta(1,1)
    %
    % List of outputs
    %   h         : null hypothesis rejected (logical)
    %   bf        : bayes factor
    %   stats     : statistics
    %
    % List of parameters
    %   'alpha'   : probability of rejecting the null hypothesis
    %   'prior'   : vector containing [a,b] parameters for the prior
    % 
    % See also bayes
    
    %% function
    varargout = {};
    
    % default
    dflt = struct('alpha',{0.05},'prior',{[1,1]});
    pars = pair2struct(varargin{:});
    pars = struct_default(pars,dflt);
    
    % prior, likelihood
    prior           = pars.prior;
    likelihood_x    = [sum(logical(x)),sum(logical(~x))];
    likelihood_y    = [sum(logical(y)),sum(logical(~y))];
    
    % probability of the data conditioned on the model
    prob_null = beta(prior(1) + likelihood_x(1) + likelihood_y(1) , prior(2) + likelihood_x(2) + likelihood_y(2));
    prob_altx = beta(prior(1) + likelihood_x(1), prior(2) + likelihood_x(2));
    prob_alty = beta(prior(1) + likelihood_y(1), prior(2) + likelihood_y(2));
    prob_alt  = prob_altx * prob_alty;
    
    % bayes factor
    bf = prob_alt / prob_null;
    
    % test
    h  = bf > 1;
    stats = struct('h',{h},'bf',{bf});
    stats.prior       = prior;
    stats.likelihood  = likelihood_x;
    stats.null        = prob_null;
    stats.alternative = prob_alt;
    
    % output
    if nargout, varargout = {h,bf,stats}; return; end
    
    % plot & print
    print_results(stats,'believe in different biases');
end
