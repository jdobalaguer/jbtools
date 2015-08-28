
function rdm = scan_tool_rsa_buildrdm(scan,beta,X,Y)
    %% rdm = SCAN_TOOL_RSA_BUILDRDM(scan,beta)
    % RSA toolbox - create RDM
    % to list main functions, try
    %   >> help scan;
    
    %% function
    switch scan.job.distance
        case 'diff'
            rdm = pdist(beta,@pdistDiff);
        case 'dot'
            rdm = pdist(beta,@pdistDot);
        case {'euclidean','seuclidean','cityblock','minkowski'}
            rdm = pdist(beta,scan.job.distance);
            rdm = rdm ./ sqrt(size(beta,2));
        case {'chebychev','cosine','correlation','spearman','hamming','jaccard'}
            rdm = pdist(beta,scan.job.distance);
        case 'mahalanobis'
            scan_tool_assert(scan,~strcmp(scan.job.transformation,'mean'),'dude, using mahalanobis distance of a mean doesn''t make any sense. are you sure you know what you''re doing?');
            rdm = pdist(beta*covdiag(Y-X*(X\Y)),'euclidean');
            rdm = rdm ./ sqrt(size(beta,2));
        otherwise
            scan_tool_error(scan,'distance "%s" is not valid',scan.job.distance);
    end
end

%% auxiliar - pdistDiff
function z = pdistDiff(x,y)
    x = repmat(x,[size(y,1),1]);
    z = nanmean(x-y,2);
end

function z = pdistDot(x,y)
    x = repmat(x,[size(y,1),1]);
    z = nanmean(x.*y,2);
end

% %% auxiliar - pdistEuclidean
% function z = pdistPeuclidean(x,y)
%     nCond  = size(y,1);
%     nVoxel = size(y,2);
%     
%     rho = corr(x',y')';
%     xx = repmat(x,[nCond,1]);
%     yy = y;
%     mx = mean(xx,2);
%     my = mean(yy,2);
%     sx = std (xx,1,2);
%     sy = std (yy,1,2);
%     
%     du = (mx - my).*(mx-my);           % univariate distance
%     dm = 2*sx.*sy.*(1-rho);            % multivariate distance
%     ds = (sx - sy).*(sx - sy);         % noise
%     z = sqrt(nVoxel*(du + dm + ds));   % final distance
% end
