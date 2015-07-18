
function scan = scan_rsa_beta(scan)
    %% scan = SCAN_RSA_BETA(scan)
    % load beta volumes from the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.load, return; end
    
    % variables
    scan.running.load.beta = nan(length(scan.running.load.subject),prod(scan.running.meta.dim),'single');
    [u_isubject, n_isubject]  = numbers(scan.running.load.gen.isubject);
    [u_isession, n_isession]  = numbers(scan.running.load.gen.isession);
    [u_order,    n_order ]    = numbers(scan.running.load.gen.order);
    [u_condition,n_condition] = numbers(scan.running.load.gen.condition);
    
    % print
    scan_tool_print(scan,false,'\nLoad beta volumes : ');
    scan_tool_progress(scan,n_isubject * n_isession);
    
    for i_isubject = 1:n_isubject
        for i_isession = 1:n_isession
            for i_order = 1:n_order
                for i_condition = 1:n_condition
                    
                    % variables
                    condition = u_condition{i_condition};
                    isubject  = u_isubject(i_isubject);
                    isession  = u_isession(i_isession);
                    order     = u_order(i_order);
                    
                    % index
                    ii_condition = strcmp(scan.running.load.gen.condition,condition);
                    ii_isubject  = (scan.running.load.gen.isubject == isubject);
                    ii_isession  = (scan.running.load.gen.isession == isession);
                    ii_order     = (scan.running.load.gen.order    == order);
                    ii = (ii_condition & ii_isubject & ii_isession & ii_order);
                    if ~any(ii), continue; end
                    
                    % load
                    scan.running.load.beta(ii,:) = scan.running.glm.function.get.beta(scan.running.glm,isubject,isession,order,condition,'');
                end
            end
            
            % wait
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
