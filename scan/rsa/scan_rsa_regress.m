
function scan = scan_rsa_regress(scan)
    %% scan = SCAN_RSA_REGRESS(scan)
    % regress models against main RDM (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.model), 'scan_rsa_regress: error. number of subjects doesnt match');
    
    % concatenate models
    u_model = {};
    for i_subject = 1:scan.subject.n
        u_model{i_subject} = [];
        for i_model = 1:length(scan.rsa.variable.model{i_subject})
            u_model{i_subject}(:,i_model) = mat2vec(scan.rsa.variable.model{i_subject}{i_model}.matrix);
        end
    end
    
    % regress
    u_rdm = scan.rsa.variable.rdm;
    scan.rsa.result = {};
    for i_subject = 1:scan.subject.n
        x = u_model{i_subject};
        y = mat2vec(u_rdm{i_subject});
        [~,~,stats] = glmfit(x,y);
        
        result.stats = stats;
        scan.rsa.result{i_subject} = result;
    end    
    
end