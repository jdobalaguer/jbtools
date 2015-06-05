
function scan = scan_rsa_load(scan)
    %% scan = SCAN_RSA_LOAD(scan)
    % load files from the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.load, return; end
    
    % print
    scan_tool_print(scan,false,'\nLoad file : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % load GLM files
    scan.running.load = struct();
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            u_column = unique(scan.running.glm.running.design(i_subject).column.name);
            if length(matlab.lang.makeValidName(u_column)) < length(u_column)
                scan_tool_warning('two or more contrasts share the same name');
            end
            ii_session = (scan.running.glm.running.design(i_subject).column.session == i_session);
            for i_column = 1:length(u_column)
                ii_column = strcmp(scan.running.glm.running.design(i_subject).column.name,u_column{i_column});
                if any(scan.running.glm.running.design(i_subject).column.covariate(ii_column & ii_session)), continue; end
                u_order  = unique(scan.running.glm.running.design(i_subject).column.order(ii_column & ii_session));
                for i_order = 1:length(u_order)
                    file = fullfile(scan.running.glm.running.directory.copy.first.beta,u_column{i_column},sprintf('subject_%03i session_%03i order_%03i.nii',scan.running.subject.unique(i_subject),i_session,u_order(i_order)));
                    vol  = scan_nifti_load(file);
                    scan.running.load.(matlab.lang.makeValidName(u_column{i_column})){i_subject}(:,i_order,i_session) = vol;
                end
            end
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);

end
