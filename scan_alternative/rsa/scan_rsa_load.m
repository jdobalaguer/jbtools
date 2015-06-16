
function scan = scan_rsa_load(scan)
    %% scan = SCAN_RSA_LOAD(scan)
    % load files from the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.load, return; end
    
    % print
    scan_tool_print(scan,false,'\nLoad beta : ');
    scan_tool_progress(scan,length(scan.job.glm.condition));
    
    scan.running.load = struct('beta',{[]},'subject',{[]},'session',{[]},'main',{{}},'name',{{}},'version',{{}},'onset',{[]});
    for i_condition = 1:length(scan.job.glm.condition)
        condition = scan.job.glm.condition{i_condition};
        scan.running.load.beta      = [scan.running.load.beta    ; single(scan.running.glm.function.get.beta  (condition,scan.job.mask))];
        scan.running.load.subject   = [scan.running.load.subject ; single(scan.running.glm.function.get.vector(condition,'subject'))];
        scan.running.load.session   = [scan.running.load.session ; single(scan.running.glm.function.get.vector(condition,'session'))];
        scan.running.load.main      = [scan.running.load.main    ;        scan.running.glm.function.get.vector(condition,'main')];
        scan.running.load.name      = [scan.running.load.name    ;        scan.running.glm.function.get.vector(condition,'name')];
        scan.running.load.version   = [scan.running.load.version ;        scan.running.glm.function.get.vector(condition,'version')];
        scan.running.load.onset     = [scan.running.load.onset   ; single(scan.running.glm.function.get.vector(condition,'onset'))];
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
end
