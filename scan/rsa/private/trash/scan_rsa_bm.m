
function scan = scan_rsa_bm(scan)
    %% scan = SCAN_RSA_BM(scan)
    % build beta matrix
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % 1. you need to choose carefully the order you want to include in your RDM (see j_column and j_order)
    % 2. this is not building the RDM yet. it's only organising and filtering the right values
    
    %% function
    if ~scan.running.flag.rdm, return; end
    
    % print
    scan_tool_print(scan,false,'\nBuild beta matrix : ');
    scan = scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % build the rdm
    scan.running.bm = {};
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            for i_mask = 1:length(scan.running.mask)
                
                % mask
                mask = logical(scan.running.mask(i_mask).mask);

                % indices
                ii_session   = (scan.running.glm.running.design(i_subject).column.session == i_session);
                ii_covariate = (scan.running.glm.running.design(i_subject).column.covariate == 0);
                ii_order     = ismember(scan.running.glm.running.design(i_subject).column.order,scan.job.glm.order);

                % column
                f_column = find(ii_session & ii_covariate & ii_order);
                for i_column = 1:length(f_column)
                    name = scan.running.glm.running.design(i_subject).column.name{f_column(i_column)};
                    order = scan.running.glm.running.design(i_subject).column.order(f_column(i_column));
                    ii_name = strcmp(scan.running.glm.running.design(i_subject).column.name,name);
                    u_order = scan.running.glm.running.design(i_subject).column.order(ii_session & ii_name & ii_covariate);
                    jj_order = (u_order == order);
                    scan.running.bm{i_subject}{i_session}(i_mask).matrix(:,i_column) = scan.running.load.(matlab.lang.makeValidName(name)){i_subject}(mask,jj_order,i_session);
                    scan.running.bm{i_subject}{i_session}(i_mask).column.name{i_column} = name;
                    scan.running.bm{i_subject}{i_session}(i_mask).column.order(i_column) = order;
                end
                scan.running.bm{i_subject}{i_session}(i_mask).column.number = length(scan.running.bm{i_subject}{i_session}(i_mask).column.name);
            end
            
            % wait
            scan = scan_tool_progress(scan,[]);
        end
    end
    scan = scan_tool_progress(scan,0);

end
