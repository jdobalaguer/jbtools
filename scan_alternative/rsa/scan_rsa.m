
function scan = scan_rsa(scan)
    %% scan = SCAN_RSA(scan)
    % Representation Similarity Analysis (RSA) script
    % to list main functions, try
    %   >> help scan;
    
    %% note
    % 1. the different columns will only match between RDM/model if you're lucky. make this robust to the order, to concatenation, to the onset marge
    % 2. the models should be able to catch a cell instead of a scalar number
    % 3. enable concatenation
    % 4. use hamed's toolbox
    % 5. in TBTE all information about the onset type is lost. this is crucial when using this information for the RSA - find a better way
    % 6. in RSA we should recycle the onset information from the TBTE.
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
        'Build model',...
        ...
        'Build beta matrix',...
        'Build RDM',...
        'Compare model',...
        ...
        'Add function');
    
    % initialize
    scan = scan_initialize(scan);               % initialize scan / SPM
    try
        scan = scan_autocomplete_rsa(scan);     % autocomplete (rsa)
        scan = scan_rsa_flag(scan);             % redo flags
        scan = scan_rsa_mkdir(scan);            % create new directories
        scan = scan_save_caller(scan);          % save caller

        % RSA
        scan = scan_rsa_load(scan);             % load beta
        scan = scan_rsa_model(scan);            % build model
        
%         % RDM
%         scan = scan_rsa_bm(scan);               % build beta matrix
%         scan = scan_rsa_rdm(scan);              % build representation dissimilarity matrix
%         scan = scan_rsa_comparison(scan);       % compare models

        % function
        scan = scan_rsa_function(scan);
        
        % save
        scan_save_scan(scan);
        scan = scan_tool_time(scan);
    catch e
        scan = scan_tool_catch(scan,e);
    end
end
