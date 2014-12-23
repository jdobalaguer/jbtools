
function scan = scan_mvpa_glmdx_concat(scan)
    %% scan = SCAN_MVPA_GLMDX_CONCAT(scan)
    % rearrange beta images and regressors for the GLMDX
    % see also scan_mvpa_glmdx
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.file), 'scan_mvpa_image: error. number of subjects doesnt match');
    
    % concatenate images and regressors (subject, session,level)
    beta = cell(scan.subject.n,1);
    regressor = struct();
    regressor.subject = [];
    regressor.session = [];
    regressor.level = [];
    for i_subject = 1:scan.subject.n
        n_image   = size(scan.mvpa.variable.beta,2);
        n_session = size(scan.mvpa.variable.beta{i_subject,1},2);
        
        subject = scan.subject.u(i_subject);
        beta{i_subject} =  cat(2,scan.mvpa.variable.beta{i_subject,:});
        regressor.subject = [regressor.subject , repmat(subject,1,size(beta{i_subject},2))];
        regressor.session = [regressor.session , repmat(1:n_session,[1,n_image])];
        regressor.level   = [regressor.level,    mat2vec(repmat(1:n_image,[n_session,1]))'];
    end
    regressor.level = repmat({regressor.level},[1,length(scan.mvpa.regressor.name)]);
    
    % discard
    regressor.discard = false(size(regressor.subject));
    
    % name
    regressor.name = {};
    for i_name = 1:length(scan.mvpa.regressor.name), regressor.name{i_name} = sprintf('%s&',scan.mvpa.regressor.name{i_name}{:}); regressor.name{i_name}(end)=[]; end
    
    % replace with previous stuff
    scan.mvpa.variable.beta = beta;
    scan.mvpa.regressor     = regressor;

end
