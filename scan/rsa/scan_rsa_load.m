
function scan = scan_rsa_load(scan)
    %% scan = SCAN_RSA_LOAD(scan)
    % load conditions from the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.load, return; end
    
    % print
    scan_tool_print(scan,false,'\nLoad GLM conditions : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    scan.running.load = struct('beta',{[]},'subject',{[]},'session',{[]},'order',{[]},'main',{{}},'name',{{}},'version',{{}},'onset',{[]},'gen',{[]});
    scan.running.load.gen = struct('condition',{{}},'isubject',{[]},'isession',{[]},'order',{[]});
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            for i_condition = 1:length(scan.job.glm.condition)
                for i_order = 1:length(scan.job.glm.order)
                    condition = scan.job.glm.condition{i_condition};
                    order     = scan.job.glm.order(i_order);
                    
                    scan.running.load.subject   = [scan.running.load.subject    ; single(scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'subject'))];
                    scan.running.load.session   = [scan.running.load.session    ; single(scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'session'))];
                    scan.running.load.order     = [scan.running.load.order      ; single(scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'order'))];
                    scan.running.load.main      = [scan.running.load.main       ;        scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'main')];
                    scan.running.load.name      = [scan.running.load.name       ;        scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'name')];
                    scan.running.load.version   = [scan.running.load.version    ;        scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'version')];
                    scan.running.load.onset     = [scan.running.load.onset      ; single(scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,order,condition,'onset'))];
                    
                    n = length(scan.running.load.subject);

                    scan.running.load.gen.condition(end+1:n,1) = {condition};
                    scan.running.load.gen.isubject(end+1:n,1)  = i_subject;
                    scan.running.load.gen.isession(end+1:n,1)  = i_session;
                    scan.running.load.gen.order    (end+1:n,1) = order;
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
