
function scan = scan_mvpa_initialize(scan)
    %% SCAN_MVPA_INITIALIZE()
    % initialize variables for the multi-voxel pattern analysis
    % see also scan_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    scan.mvpa.subject = init_subj('','');
    for i_subject = 1:scan.subject.n
        subject  = scan.subject.u(i_subject);
        scan.mvpa.subject(i_subject) = init_subj(scan.mvpa.name,sprintf('subject_%02i',subject));
    end

end