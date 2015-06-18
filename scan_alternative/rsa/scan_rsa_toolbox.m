
function scan = scan_rsa_toolbox(scan)
    %% scan = SCAN_RSA_TOOLBOX(scan)
    % interface to the RSA toolbox (cambridge)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.toolbox, return; end
    
    % print
    scan_tool_print(scan,false,'\nToolbox : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            toolbox = struct();
        
            % create userOptions
            toolbox.userOptions         = scan_tool_rsa_userOptions(scan,i_subject);
            toolbox.singleSubjectVols   = scan_tool_rsa_fMRIDataPreparation(scan,i_subject,i_session);
            toolbox.binaryMask          = scan_tool_rsa_fMRIMaskPreparation(scan,i_subject);
            toolbox.models              = scan_tool_rsa_constructModelRDMs(scan,i_subject,i_session);
            toolbox.searchlightOptions  = struct('monitor',false,'fisher',true,'nSessions',1,'nConditions',size(toolbox.singleSubjectVols,2));

            % searchlight
            [~,toolbox.result.rs, toolbox.result.ps, toolbox.result.ns, toolbox.result.searchlightRDMs] = evalc('searchlightMapping_fMRI(toolbox.singleSubjectVols,toolbox.models,toolbox.binaryMask,toolbox.userOptions,toolbox.searchlightOptions);');
            
            % visualisation
            toolbox = scan_tool_rsa_maps(scan,toolbox,i_subject,i_session);
            
            % save
            scan.running.toolbox{i_subject}{i_session} = toolbox;
            
            % wait
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
end
