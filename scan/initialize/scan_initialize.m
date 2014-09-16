
function scan = scan_initialize(scan)
    %% scan = SCAN_INITIALIZE([scan])
    % initialize a struct containing any necessary parameters.
    % this function must be executed from the root directory.
    % see also scan_preprocess_run
    %          scan_glm_run
    %          scan_mvpa_run
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    if ~exist('scan','var'), scan = struct(); end
    scan = scan_initialize_set(scan);
    scan_initialize_assert(scan);
    
end