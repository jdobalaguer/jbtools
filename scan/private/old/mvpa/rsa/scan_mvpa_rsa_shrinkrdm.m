
function scan = scan_mvpa_rsa_shrinkrdm(scan)
    %% scan = SCAN_MVPA_RSA_SHRINKRDM(scan)
    % shrink RDMs (RSA)
    % see also scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~scan.mvpa.shrink, return; end
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.rdm),        'scan_mvpa_rsa_shrinkrdm: error. number of subjects doesnt match');
    assert(scan.subject.n == length(scan.mvpa.variable.regressor),  'scan_mvpa_rsa_shrinkrdm: error. number of subjects doesnt match');
    
    warning('scan_mvpa_rsa_shrinkrdm: warning. non-pooling TODO');
    
    % shrink rdm
    scan.mvpa.variable.subrdm = {};
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('scan_rsa: shrink subject %02i: \n',subject);
        scan.mvpa.variable.subrdm{i_subject} = {};
        
        % load
        rdm = scan.mvpa.variable.rdm{i_subject};
        
        % shrink
        for i_regressor = 1:length(scan.mvpa.variable.regressor{i_subject})
            
            % numbers
            [u_level,n_level] = numbers(scan.mvpa.variable.regressor{i_subject}{i_regressor}.level);
            l_level = length(scan.mvpa.variable.regressor{i_subject}{i_regressor}.level);
            n_beta = size(scan.mvpa.variable.rdm{i_subject},1);
            
            % assert
            assert(l_level==n_beta, 'scan_mvpa_rsa_shrinkrdm: error. number of images doesnt match');
            
            % create
            subrdm = struct();
            subrdm.name   = scan.mvpa.variable.regressor{i_subject}{i_regressor}.name;
            subrdm.level  = u_level;
            subrdm.size   = n_level;
            subrdm.matrix = nan(n_level,n_level);

            for i_level1 = 1:n_level
                for i_level2 = i_level1:n_level
                    ii_level1 = (scan.mvpa.variable.regressor{i_subject}{i_regressor}.level == u_level(i_level1));
                    ii_level2 = (scan.mvpa.variable.regressor{i_subject}{i_regressor}.level == u_level(i_level2));
                    subrdm.matrix(i_level1,i_level2) = nanmean(mat2vec(rdm(ii_level1,ii_level2)));
                    subrdm.matrix(i_level2,i_level1) = nanmean(mat2vec(rdm(ii_level1,ii_level2)));
                end
            end
            
            % save
            scan.mvpa.variable.subrdm{i_subject}{i_regressor} = subrdm;
        end
    end
end