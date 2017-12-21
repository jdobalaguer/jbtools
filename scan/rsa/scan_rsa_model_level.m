
function scan = scan_rsa_model_level(scan)
    %% scan = SCAN_RSA_MODEL_LEVEL(scan)
    % build levels for the model
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % levels are the extra regressors that go on top of the onsets
    % this doesn't take [scan.job.glm.order] into account (but that's ok -see scan_function_tbte_get_vector)
    % these are used only with glms of type "tbte"
    
    %% function
    if ~scan.running.flag.model, return; end
    
    % build levels
    for i_model = 1:length(scan.job.model)
        
        scan.running.model(i_model).level = {};
        
        % set level
        for i_subject = 1:scan.running.subject.number
            [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
            for i_session = 1:n_session

                u_condition = scan.job.glm.condition;
                for i_condition = 1:length(u_condition)
                    
                    if isempty(scan.job.model(i_model).subname)
                        % if no levels there
                        scan.running.model(i_model).level{i_subject}{i_session}{i_condition} = cell(1,0);
                    else
                        % add levels
                        u_level = scan.job.model(i_model).subname{i_condition};
                        for i_level = 1:length(u_level)
                            scan.running.model(i_model).level{i_subject}{i_session}{i_condition}{i_level} = struct('name',{[]},'value',{[]});
                            scan.running.model(i_model).level{i_subject}{i_session}{i_condition}{i_level}.name  = u_level{i_level};
                            scan.running.model(i_model).level{i_subject}{i_session}{i_condition}{i_level}.value = scan.running.glm.function.get.vector(scan.running.glm,i_subject,i_session,1,u_condition{i_condition},scan.job.model(i_model).level{i_condition}{i_level});
                        end
                    end
                end
            end
        end
    end
end
