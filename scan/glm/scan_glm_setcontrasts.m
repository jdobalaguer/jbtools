
function scan = scan_glm_setcontrasts(scan)
    %% SCAN_GLM_SETCONTRASTS()
    % set contrasts for the GLM
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW>
    
    %% FUNCTION
    scan.glm.contrast  = {};
    for i_subject = 1:scan.subject.n
        scan.glm.contrast{i_subject} = {};
        j_contrast = 0;
        
        % get condition
        condition = load(sprintf('%sfinal_condition_sub_%02i.mat',scan.dire.glm.regressor,scan.subject.u(i_subject)),'condition');
        condition = condition.condition{1};
        
        % get order
        switch(scan.glm.function)
            case 'hrf', n_order = 1+sum(scan.glm.hrf.ord);
            case 'fir', n_order = scan.glm.fir.ord;
        end
        
        % get generic contrasts
        u_generic = {};
        for i_condition = 1:length(condition)
            u_generic = [u_generic, {condition{i_condition}.name}, condition{i_condition}.subname];
        end
        n_generic = length(u_generic);
        
        % set generic contrasts
        if scan.glm.contrasts.generic
            for i_generic = 1:n_generic
                for i_order = 1:n_order
                    name_contrast = sprintf('%s_%03i',u_generic{i_generic},i_order);
                    conv_contrast = zeros(n_order,n_generic);
                    conv_contrast(i_order,i_generic) = 1;
                    conv_contrast = mat2vec(conv_contrast)';
                    j_contrast = j_contrast + 1;
                    scan.glm.contrast{i_subject}{j_contrast} = struct('name',name_contrast, 'convec',conv_contrast,'sessrep','replsc');
                end
            end
        end
        
        % set extra contrasts
        if ~isempty(scan.glm.contrasts.extra)
            for i_extra = 1:length(scan.glm.contrasts.extra)
                for i_order = 1:n_order
                    name_contrast = sprintf('%s_%03i',scan.glm.contrasts.extra(i_extra).name,i_order);
                    conv_contrast = zeros(n_order,n_generic);
                    for i_regressor = 1:length(scan.glm.contrasts.extra(i_extra).regressor)
                        tmp_found = false;
                        for i_generic = 1:length(u_generic)
                            if tmp_found, break; end
                            if strcmp(scan.glm.contrasts.extra(i_extra).regressor{i_regressor},u_generic{i_generic})
                                tmp_found = true;
                                conv_contrast(i_order,i_generic) = scan.glm.contrasts.extra(i_extra).weight(i_regressor);
                            end
                        end
                    end
                    conv_contrast = mat2vec(conv_contrast)';
                    j_contrast = j_contrast + 1;
                    scan.glm.contrast{i_subject}{j_contrast} = struct('name',name_contrast, 'convec',conv_contrast);
                end
            end
        end
        
    end
end