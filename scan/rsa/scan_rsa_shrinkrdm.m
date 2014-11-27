
function scan = scan_rsa_shrinkrdm(scan)
    %% scan = SCAN_RSA_SHRINKRDM(scan)
    % load images (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~scan.rsa.shrink, return; end
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.rdm), 'scan_rsa_createrdm: error. number of subjects doesnt match');
    
    % shrink rdm
    scan.rsa.variable.subrdm = {};
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('scan_rsa: shrink subject %02i: \n',subject);
        scan.rsa.variable.subrdm{i_subject} = {};
        
        % load
        rdm = scan.rsa.variable.rdm{i_subject};
        
        % shrink
        for i_regressor = 1:length(scan.rsa.regressor.name)
            
            % discarded images
            ii_subject = (scan.rsa.regressor.subject == subject);
            if isempty(scan.rsa.regressor.discard),
                ii_discard = false(size(scan.rsa.regressor.subject));
            else
                ii_discard = (scan.rsa.regressor.discard);
            end
            ii_regressor = (ii_subject & ~ii_discard);

            % numbers
            [u_level,n_level] = numbers(scan.rsa.regressor.level{i_regressor}(ii_regressor));
            n_beta = size(scan.rsa.variable.rdm{i_subject},1);
            
            % assert
            assert(sum(ii_regressor)==n_beta, 'scan_rsa_shrinkrdm: error. number of subjects doesnt match');
            
            % create
            subrdm = struct();
            subrdm.name   = scan.rsa.regressor.name{i_regressor};
            subrdm.level  = u_level;
            subrdm.size   = n_level;
            subrdm.matrix = nan(n_level,n_level);

            for i_level1 = 1:n_level
                for i_level2 = i_level1:n_level
                    ii_level1 = (scan.rsa.regressor.level{i_regressor}(ii_regressor) == u_level(i_level1));
                    ii_level2 = (scan.rsa.regressor.level{i_regressor}(ii_regressor) == u_level(i_level2));
                    subrdm.matrix(i_level1,i_level2) = nanmean(mat2vec(rdm(ii_level1,ii_level2)));
                    subrdm.matrix(i_level2,i_level1) = nanmean(mat2vec(rdm(ii_level1,ii_level2)));
                end
            end
            
            % save
            scan.rsa.variable.subrdm{i_subject}{i_regressor} = subrdm;
        end
    end
end