
function scan = scan_rsa_model_level(scan)
    %% scan = SCAN_RSA_MODEL_LEVEL(scan)
    % build levels for the model
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.model, return; end
    
    % build levels
    for i_model = 1:length(scan.job.model)
        % variables
        u_condition = scan.job.glm.condition;
        u_subname   = unique(cell_flat(scan.job.model(i_model).subname),'stable');
        level       = cell(length(u_condition),length(u_subname));
       
        % set level
        n = nan(1,length(u_condition));
        for i_condition = 1:length(u_condition)
            n(i_condition) = sum(strcmp(scan.running.load.name,u_condition{i_condition}));
            for i_subname = 1:length(u_subname)
                ii_condition = strcmp(scan.job.model(i_model).condition,u_condition{i_condition});
                ii_subname   = strcmp(scan.job.model(i_model).subname{ii_condition},u_subname{i_subname});
                if any(ii_subname)
                    level{i_condition,i_subname} = scan.running.glm.function.get.vector(u_condition{i_condition},scan.job.model(i_model).level{ii_condition}{ii_subname});
                end
            end
        end
        
        % fill in empty levels
        for i_condition = 1:length(u_condition)
            for i_subname = 1:length(u_subname)
                if isempty(level{i_condition,i_subname})
                    level{i_condition,i_subname} = nan(n(i_condition),1);
                end
            end
        end
        
        % save model
        scan.running.model(i_model).level.name  = u_subname; 
        scan.running.model(i_model).level.value = level;
    end
end
