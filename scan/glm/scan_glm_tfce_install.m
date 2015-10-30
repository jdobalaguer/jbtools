
function scan = scan_glm_tfce_install(scan)
    %% scan = SCAN_GLM_TFCE_INSTALL(scan)
    % download/install TFCE-toolbox, by Christian Gaser
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % paths
    path_toolbox = fullfile(spm('Dir'),'toolbox');
    
    % set URL
    url = 'http://dbm.neuro.uni-jena.de/tfce/tfce_r78.zip';
    
    % print
    scan_tool_print(scan,false,'Installing TFCE-toolbox from "%s"',url);
    scan_tool_assert(scan,strcmp(input('Do you understand that this is an external library? Type "yes" : ','s'),'yes'),'Cancelled.');
    scan = scan_tool_progress(scan,1);
    
    % download and extract
    unzip(url,path_toolbox);
    
    % end of progress
    scan = scan_tool_progress(scan,[]);
    scan = scan_tool_progress(scan,0);
    
    % update
    scan = scan_glm_tfce_update(scan);
    
    % reset SPM
    scan = scan_initialize_spm(scan);
end
