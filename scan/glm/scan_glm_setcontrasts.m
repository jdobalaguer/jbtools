
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
        
        % set names
        condition = load(sprintf('%sfinal_condition_sub_%02i.mat',scan.dire.glm.regressor,scan.subject.u(i_subject)),'condition');
        condition = condition.condition;
        u_name = {};
        for i = 1:length(condition{1})
            u_name = [u_name, {condition{1}{i}.name}, condition{1}{i}.subname];
        end
        n_name = length(u_name);
        
        % set order
        switch(scan.glm.function)
            case 'hrf', n_order = 1+sum(scan.glm.hrf.ord);
            case 'fir', n_order = scan.glm.fir.ord;
        end
        
        % set contrasts
        j_name = 0;
        for i_name = 1:n_name
            for i_order = 1:n_order
                j_name = j_name + 1;
                name_contrast = sprintf('%s_%03i',u_name{i_name},i_order);
                conv_contrast = zeros(1,n_name*n_order);
                conv_contrast(j_name) = 1;
                scan.glm.contrast{i_subject}{j_name} = struct('name',name_contrast, 'convec',conv_contrast);
            end
        end
    end
end