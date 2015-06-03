
function scan = scan_glm_contrast(scan)
    %% scan = SCAN_GLM_CONTRAST(scan)
    % define contrasts
    % to list main functions, try
    %   >> help scan;
    
    %% note
    % don't add the _001 to the [scan.running.contrast.name]
    % keep it as a different field, and you can add it later when you save it in files.
    % this will make some things easier (like getting the FIR for contrasts)
    % it may break some stuff. you'll need to check where you've been using the contrasts' names.

    %% function
    if ~scan.running.flag.contrast, return; end
    
    % print
    scan_tool_print(scan,false,'\nSet contrast : ');
    scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % variable
        j_contrast = 0;
        scan.running.contrast{i_subject} = struct('name',{},'vector',{},'order',{});
        
        % generic
        u_column = unique(scan.running.design(i_subject).column.name);
        for i_column = 1:length(u_column)
            for i_order = 1:length(scan.job.contrast.generic)
                ii_column = strcmp(u_column{i_column},scan.running.design(i_subject).column.name);
                ii_order  = (scan.running.design(i_subject).column.order == scan.job.contrast.generic(i_order));
                vector = (ii_column & ii_order) / sum(ii_column & ii_order);
                if any(vector),
                    j_contrast = j_contrast + 1;
                    scan.running.contrast{i_subject}(j_contrast) = struct('name',{u_column{i_column}},'vector',{vector},'order',{i_order});
                end
            end
        end
        clear u_column;
        
        % extra
        for i_extra = 1:length(scan.job.contrast.extra)
            for i_order = 1:length(scan.job.contrast.extra(i_extra).order{1})
                vector = zeros(1,scan.running.design(i_subject).column.number);
                for i_column = 1:length(scan.job.contrast.extra(i_extra).column)
                    ii_column = strcmp(scan.job.contrast.extra(i_extra).column{i_column},scan.running.design(i_subject).column.name);
                    ii_order  = (scan.running.design(i_subject).column.order == scan.job.contrast.extra(i_extra).order{i_column}(i_order));
                    if ~any(ii_column & ii_order)
                        scan_tool_warning(scan,true,'In contrast "%s" we couldnt find a column "%s" with order "%03i"',scan.job.contrast.extra(i_extra).name,scan.job.contrast.extra(i_extra).column{i_column},i_order);
                    end
                    vector(ii_column & ii_order) = scan.job.contrast.extra(i_extra).weight(i_column) / sum(ii_column & ii_order);
                end
                if any(vector)
                    j_contrast = j_contrast + 1;
                    scan.running.contrast{i_subject}(j_contrast) = struct('name',{scan.job.contrast.extra(i_extra).name},'vector',{vector},'order',i_order);
                end
            end
        end
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
    
end
