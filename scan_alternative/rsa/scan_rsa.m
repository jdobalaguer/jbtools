
function scan = scan_rsa(scan)
    %% scan = SCAN_RSA(scan)
    % Representation Similarity Analysis (RSA) script
    % to list main functions, try
    %   >> help scan;
    
    %% note
    % 1. the different columns will only match between RDM/model if you're lucky. make this robust to the order, to concatenation, to the onset marge
    % 2. the models should be able to catch a cell instead of a scalar number
    % 3. enable concatenation
    % 7. filter RSA, concatenate RSA
    % 8. re-sort RDMs, shrink RDMs

    %% function
    
    % job type
    scan.job.type = 'rsa';
    
    % summary
    scan_tool_summary(scan,'Representation Similarity Analysis (RSA)',...
        'Initialize',...
        ...
        'Load beta',...
        'Load metadata',...
        'Load mask',...
        'Build model',...
        ...
        'Toolbox',...
        ...
        'Add function');
    
    % initialize
    scan = scan_initialize(scan);               % initialize scan / SPM
    try
        scan = scan_autocomplete_rsa(scan);     % autocomplete (rsa)
        scan = scan_autocomplete_mask(scan,scan.running.glm.job.image); % autocomplete (mask)
        scan = scan_rsa_flag(scan);             % redo flags
        scan = scan_rsa_mkdir(scan);            % create new directories
        scan = scan_save_caller(scan);          % save caller

        % set stuff
        scan = scan_rsa_beta(scan);             % load beta
        scan = scan_rsa_meta(scan);             % load meta
        scan = scan_rsa_mask(scan);             % load mask
        scan = scan_rsa_model(scan);            % build model
        scan.running.subject.session(:) = 1;
        
        % RDM
        scan = scan_rsa_toolbox(scan);          % initialise RSA toolbox

        % function
        scan = scan_rsa_function(scan);
        
        % save
        scan_save_scan(scan);
        scan = scan_tool_time(scan);
    catch e
        scan = scan_tool_catch(scan,e);
    end
end
