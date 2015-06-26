
function scan = scan_rsa_beta(scan)
    %% scan = SCAN_RSA_BETA(scan)
    % load files from the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.load, return; end
    
    % print
    scan_tool_print(scan,false,'\nLoad beta : ');
    scan_tool_progress(scan,length(scan.job.glm.condition));
    
    scan.running.load = struct('beta',{[]},'subject',{[]},'session',{[]},'order',{[]},'main',{{}},'name',{{}},'version',{{}},'onset',{[]});
    for i_condition = 1:length(scan.job.glm.condition)
        condition = scan.job.glm.condition{i_condition};
        scan.running.load.beta      = [scan.running.load.beta    ; single(scan.running.glm.function.get.beta  (scan.running.glm,condition,''))];
        scan.running.load.subject   = [scan.running.load.subject ; single(scan.running.glm.function.get.vector(scan.running.glm,condition,'subject'))];
        scan.running.load.session   = [scan.running.load.session ; single(scan.running.glm.function.get.vector(scan.running.glm,condition,'session'))];
        scan.running.load.order     = [scan.running.load.order   ; single(scan.running.glm.function.get.vector(scan.running.glm,condition,'order'))];
        scan.running.load.main      = [scan.running.load.main    ;        scan.running.glm.function.get.vector(scan.running.glm,condition,'main')];
        scan.running.load.name      = [scan.running.load.name    ;        scan.running.glm.function.get.vector(scan.running.glm,condition,'name')];
        scan.running.load.version   = [scan.running.load.version ;        scan.running.glm.function.get.vector(scan.running.glm,condition,'version')];
        scan.running.load.onset     = [scan.running.load.onset   ; single(scan.running.glm.function.get.vector(scan.running.glm,condition,'onset'))];
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
    
    % transformation
    switch scan.job.transformation
        case 'none'
        case 'demean'
            scan.running.load.beta = vec_demean(scan.running.load.beta,vec_rows(scan.running.load.subject,scan.running.load.session,scan.running.load.order,scan.running.load.name));
        case 'zscore'
            scan.running.load.beta = vec_zscore(scan.running.load.beta,vec_rows(scan.running.load.subject,scan.running.load.session,scan.running.load.order,scan.running.load.name));
        otherwise
            scan_tool_error(scan,'transformation "%s" not valid',scan.job.transformation);
    end
end
