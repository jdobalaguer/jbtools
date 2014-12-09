
function scan = scan_mvpa_searchlight_start(scan)
    %% scan = SCAN_MVPA_SEARCHLIGHT_START(scan)
    % prepare searchlight
    % see also scan_mvpa_dx_searchlight
    % see also scan_mvpa_rsa_searchlight
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.beta), 'scan_mvpa_searchlight_start: error. number of subjects doesnt match');
    assert(scan.subject.n == length(scan.mvpa.variable.mask), 'scan_mvpa_searchlight_start: error. number of subjects doesnt match');
    
    % remove nan
    for i_subject = 1:scan.subject.n
        ii_nan = any(isnan(scan.mvpa.variable.beta{i_subject}),2);
        scan.mvpa.variable.mask{i_subject}(ii_nan) = 0;
    end
    
    % save values
    scan.mvpa.variable.searchlight = struct();
    scan.mvpa.variable.searchlight.beta = scan.mvpa.variable.beta;
    scan.mvpa.variable.searchlight.mask = scan.mvpa.variable.mask;
    
    % set searchlight
    for i_subject = 1:scan.subject.n
        % number of spheres
        scan.mvpa.variable.searchlight.n_sphere(i_subject)  = sum(mat2vec(scan.mvpa.variable.searchlight.mask{i_subject}));
        % initalize result
        scan.mvpa.variable.result.searchlight{i_subject} = {};
        for i_regressor = 1:length(scan.mvpa.regressor.name)
            scan.mvpa.variable.result.searchlight{i_subject}{i_regressor} = nan(1,scan.mvpa.variable.searchlight.n_sphere(i_subject));
        end
    end
    
end
