
function scan = scan_rsa_beta(scan)
    %% scan = SCAN_RSA_BETA(scan)
    % load files from the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.load, return; end
    
    % print
    scan_tool_print(scan,false,'\nLoad beta : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    scan.running.load = struct('beta',{[]},'subject',{[]},'session',{[]},'order',{[]},'main',{{}},'name',{{}},'version',{{}},'onset',{[]});
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            for i_condition = 1:length(scan.job.glm.condition)
                for i_order = 1:length(scan.job.glm.order)
                    condition = scan.job.glm.condition{i_condition};
                    order     = scan.job.glm.order(i_order);
                    
                    scan.running.load.beta      = [scan.running.load.beta    ; single(scan.running.glm.function.get.beta  (scan.running.glm,i_subject,i_session,order,condition,''))];
                    scan.running.load.subject   = [scan.running.load.subject ; single(scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'subject'))];
                    scan.running.load.session   = [scan.running.load.session ; single(scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'session'))];
                    scan.running.load.order     = [scan.running.load.order   ; single(scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'order'))];
                    scan.running.load.main      = [scan.running.load.main    ;        scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'main')];
                    scan.running.load.name      = [scan.running.load.name    ;        scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'name')];
                    scan.running.load.version   = [scan.running.load.version ;        scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'version')];
                    scan.running.load.onset     = [scan.running.load.onset   ; single(scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'onset'))];
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
