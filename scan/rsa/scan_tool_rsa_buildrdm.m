
function rdm = scan_tool_rsa_buildrdm(scan,beta,i_subject,i_session)
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
        case {'cross-euclidean'}
            rdm = crossEuclidean(scan,beta,i_subject,i_session);
            rdm = rdm ./ sqrt(size(beta,2));
        case {'cross-correlation'}
            beta = mat_zscore(beta,2);
            rdm = crossEuclidean(scan,beta,i_subject,i_session);
            rdm = rdm ./ sqrt(size(beta,2));
        otherwise
            scan_tool_error(scan,'distance "%s" is not valid',scan.job.distance);
    end
end

%% auxiliar - diff
function z = pdistDiff(x,y)
    x = repmat(x,[size(y,1),1]);
    z = nanmean(x-y,2);
end

%% auxiliar - diff
function z = pdistDot(x,y)
    x = repmat(x,[size(y,1),1]);
    z = nanmean(x.*y,2);
end

%% auxiliar - crossEuclidean

function rdm = crossEuclidean(scan,beta,i_subject,~)
    % note: this function should only be used with concatenated sessions
    %       but i dont assert this because this also runs within a searchlight
    
    % vector conditions
    if scan.job.padSessions
        u_condition = mat2vec(1:length(scan.job.glm.condition));
        u_session   = unique(scan.running.load.session,'stable');
        [x_condition,x_session] = ndgrid(u_condition,u_session);
        x_session   = mat2vec(x_session);
        x_condition = mat2vec(x_condition);
    else
        ii_subject = (scan.running.load.subject == scan.running.subject.unique(i_subject));
        x_session   = scan.running.load.session(ii_subject);
        x_condition = scan.running.load.name(ii_subject);
        [~,~,x_condition] = unique(x_condition);
    end
    
    % numbers
    n_pattern  = length(x_condition);
    n_distance  = 0.5 * n_pattern * (n_pattern-1);
    
    % matrix conditions
    [z_c1,z_c2] = ndgrid(x_condition,x_condition);
    [z_s1,z_s2] = ndgrid(x_session,  x_session  );
    z_distance  = tril(squareform(true(1,n_distance)));
    z_sc        = cat(2,z_s1(:),z_s2(:),z_c1(:),z_c2(:));
    z_sc        = z_sc(z_distance,:);
    clear z_c1 z_c2 z_s1 z_s2;
    
    % discard RDM cells because of symmetry
    ii_rdm  = (z_sc(:,1)~=z_sc(:,2)) & (z_sc(:,3)>z_sc(:,4));
    z_sc(~ii_rdm,:) = [];
    
    % extract betas
    x_pattern = (1:n_pattern)';
    z_s1 = (z_sc(:,1)==x_session');
    z_s2 = (z_sc(:,2)==x_session');
    z_c1 = (z_sc(:,3)==x_condition');
    z_c2 = (z_sc(:,4)==x_condition');
    
    % maybe this could be improved..?
    b_s1c1 = beta(sum(double(z_s1 & z_c1) .* x_pattern',2),:);
    b_s1c2 = beta(sum(double(z_s1 & z_c2) .* x_pattern',2),:);
    b_s2c1 = beta(sum(double(z_s2 & z_c1) .* x_pattern',2),:);
    b_s2c2 = beta(sum(double(z_s2 & z_c2) .* x_pattern',2),:);
    
    rdm = nan(1,n_distance);
    rdm(ii_rdm) = sum((b_s1c1 - b_s1c2) .* (b_s2c1 - b_s2c2),2);
end
