
function beta = scan_tool_rsa_whitening(scan,beta,R,i_subject,i_session)
    %% rdm = SCAN_TOOL_RSA_WHITENING(scan,beta,R,i_subject,i_session)
    % RSA toolbox - create RDM
    % to list main functions, try
    %   >> help scan;
    
    %% warnings
    %#ok<*DEFNU>
    
    %% function
    
    if scan.job.concatSessions
        % do whitening of betas independently for each session
        ii_subject = (scan.running.load.subject == scan.running.subject.unique(i_subject));
        u_session = unique(scan.running.glm.running.design(i_subject).column.session);
        n_session = length(u_session);
        for i_session = 1:n_session
            ii_session = (scan.running.load.session == u_session(i_session));
            ii = ii_session(ii_subject);
            beta(ii,:) = beta(ii,:) * mpower(covdiag(R{i_session}),-.5);
        end
    else
        % sessions not concatenated, so choose the residuals of this session
        % the code for [scan.job.concatSessions] should also work, but this is faster
        beta = beta * mpower(covdiag(R{i_session}),-.5);
    end
end

%% auxiliar - janWhitening
% trying to speed-up the whitening, though this is actually slower
function beta = janWhitening(beta,R)
    [~,S,V] = svd(bsxfun(@minus,R,mean(R)),'econ');
    S = diag(S);
    % remove singular values close to zero, for ill-conditioned matrices
    ii = S./max(S) < 1e-5; S(ii) = []; V(:,ii) = [];
    % whitening
    beta = beta*V*full(sparse(diag(1./S))*V');
    beta = single(beta);
end

%% auxiliar - covdiag
% modified from the RSA toolbox
% https://github.com/rsagroup/rsatoolbox/blob/b67d4df7a1513d18304fdbfc3734cf737d8d4d3a/%2Brsa/%2Bstat/covdiag.m

% function [sigma,shrinkage]=covdiag(x,df)
% Regularises the estimate of the covariance matrix accroding to the 
% optimal shrikage method as outline in Ledoit& Wolf (2005).
% Shrinks towards diagonal matrix
% INPUT  R (t*n): t observations on p random variables
% OUTPUT C (n*n): invertible covariance matrix estimator
% 
function C = covdiag(R)
    % de-mean returns
    [t,n]=size(R);
    R=bsxfun(@minus,R,sum(R)./t);  % Subtract mean of each time series fast  

    % compute sample covariance matrix
    df=t-1; 
    
    % Compute sample covariance matrix
    sample = (1/df).*(R'*R);

    % compute prior
    prior = diag(diag(sample));

    % if required, compute shrinkage parameter using Ledoit-Wolf method 
    d  = 1/n*norm(sample-prior,'fro')^2;
    y  = R.^2;
    r2 = 1/n/df^2*sum(sum(y'*y))-1/n/df*sum(sum(sample.^2));
    shrinkage = max(0,min(1,r2/d));

    % regularize the estimate
    C = shrinkage*prior+(1-shrinkage)*sample;
    C = single(C);
end
