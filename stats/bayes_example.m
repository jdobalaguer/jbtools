
function bayes_example
    %% BAYES_EXAMPLE()
    % example of the use of fig_ functions

    %% Utilities
    
    % find and plot a probability density function
    x = cat(1,randn(10,1)-3,randn(20,1)+3);
    bayes_pdf(x);
    
    % define and plot a space of independent beta functions
    pars1 = [20, 6]; % [a,b]
    pars2 = [ 2, 4];
    beta  = bayes_pdf_beta(pars1,pars2); %#ok<NASGU>
    bayes_beta2_plot(beta);

    %% Bernouilli processes
    
    % one variable: tests whether bias is smaller than 0.5
    [z,N] = deal(2,10);
    x = [ones(z,1) ; zeros(N-z,1)];
    bayes_beta1_null(x,'tail','left','prior',[1,4]);
    
    % one variable: tests whether bias is within an interval (ROPE)
    [z,N] = deal(62,120);
    rope  = [0.4 , 0.6];
    x = [ones(z,1) ; zeros(N-z,1)];
    bayes_beta1_rope(x,'prior',[4,3],'rope',rope);
    
    % two variables: calculates the bayes factor of two separate biases vs one common bias
    x = zeros(10,1); x(1:2) = 1;
    bayes_beta2_bf(x,x,'prior',[1,1]);
    bayes_beta2_bf(x,~x);
    
    %% Gaussian processes
    % TODO
    
    %% Markov-Chain Monte-Carlo (MCMC) approximations
    
    % one variable: equivalent to @ttest
    prior      = bayes_pdf_beta([1,   4]);   % this is p(z), the prior
    likelihood = bayes_pdf_beta([2+1,8+1]); % this is p(d|z) with 8/10 heads
    bayes_mcmc1_null(prior,likelihood,'index',1,'tail','left','alpha',0.05,...
                                      'mcmc_initial',0.5,'mcmc_nsamples',2e3);
    fig_axis(struct('xlim',{[0,1]}));
                                  
    % two variables: equivalent to @ttest2
    prior      = bayes_pdf_beta([1,1],[1,1]); % this is p(z1,z2), the prior
    likelihood = bayes_pdf_beta([2+1,8+1],[4+1,2+1]); % this is p(d|z1,z2) with 8/10 heads and 4/6 heads for each coin
    bayes_mcmc2_null(prior,likelihood,'index',[1,2],'tail','left','alpha',0.05,...
                                      'mcmc_initial',[0.5,0.5],'mcmc_nsamples',2e3);
    fig_axis(struct('xlim',{[0,1]},'ylim',{[0,1]}));
end
