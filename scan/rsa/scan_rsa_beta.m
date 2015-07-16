
function scan = scan_rsa_beta(scan)
    %% scan = SCAN_RSA_BETA(scan)
    % load beta volumes from the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.load, return; end
    
    % variables
    n_condition = length(scan.running.load.subject);
    scan.running.load.beta = nan(n_condition,prod(scan.running.meta.dim),'single');
    
    % print
    scan_tool_print(scan,false,'\nLoad beta volumes : ');
    scan_tool_progress(scan,n_condition);
    
    for j_condition = 1:n_condition
        
        % variables
        condition = scan.running.load.gen.condition{j_condition};
        i_subject = scan.running.load.gen.isubject(j_condition);
        i_session = scan.running.load.gen.isession(j_condition);
        order     = scan.running.load.gen.order(j_condition);

        % load
        scan.running.load.beta(j_condition,:) = scan.running.glm.function.get.beta(scan.running.glm,i_subject,i_session,order,condition,'');
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
