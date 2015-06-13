
function scan = scan_glm_contrast(scan)
    %% scan = SCAN_GLM_CONTRAST(scan)
    % define contrasts
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.first, return; end
    
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
            if ~isempty(scan.job.contrast.generic.name) && ~any(strcmp(u_column{i_column},scan.job.contrast.generic.name)), continue; end
            ii_column = strcmp(u_column{i_column},scan.running.design(i_subject).column.name);
            if all(scan.running.design(i_subject).column.covariate(ii_column)), continue; end
            for i_order = 1:length(scan.job.contrast.generic.order)
                ii_order  = (scan.running.design(i_subject).column.order == scan.job.contrast.generic.order(i_order));
                vector = (ii_column & ii_order) / sum(ii_column & ii_order);
                if any(vector),
                    j_contrast = j_contrast + 1;
                    scan.running.contrast{i_subject}(j_contrast) = struct('name',u_column(i_column),'vector',{vector},'order',{scan.job.contrast.generic.order(i_order)});
                else
%                     scan_tool_warning(scan,true,'generic contrast "%s" with order "%03i" is ignored for subject "%03i"',u_column{i_column},i_order,i_subject);
                end
            end
        end
        
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
                else
                    scan_tool_warning(scan,true,'extra contrast "%s" with order "%d" is ignored for subject "%03i"',u_column{i_column},i_order,i_subject);
                end
            end
        end
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
    
end
