
function scan = scan_rsa_model_rdm(scan)
    %% scan = SCAN_RSA_MODEL_RDM(scan)
    % build RDMs for the model
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % this function is also responsible of the concatenation
    
    %% function
    if ~scan.running.flag.model, return; end
    
    % build RDMs
    scan = scan_tool_progress(scan,length(scan.job.model) * scan.running.subject.number);
    for i_model = 1:length(scan.job.model)
        % variables
        x_subject = mat2vec([scan.running.model(i_model).column.subject]);
        x_session = mat2vec([scan.running.model(i_model).column.session]);
        rdm = cell(1,scan.running.subject.number);
        
        % subject
        for i_subject = 1:scan.running.subject.number
            ii_subject = (x_subject == i_subject);
            
            % concatenation
            n_session = scan.running.subject.session(i_subject);
            if scan.job.concatSessions, n_session = 1; end
            rdm{i_subject} = cell(1,n_session);
            
            % session
            for i_session = 1:n_session
                ii_session = (x_session == i_session);
                
                % concatenation
                if scan.job.concatSessions, ii_session(:) = 1; end
        
                % build a big RDM
                x = mat2vec(scan.running.model(i_model).column(ii_subject & ii_session));
                [ix,iy] = meshgrid(1:length(x),1:length(x));
                ix = tril(ix,-1); ix(~ix) = [];
                iy = tril(iy,-1); iy(~iy) = [];
                rdm{i_subject}{i_session}.subject = {x.subject};
                rdm{i_subject}{i_session}.session = {x.session};
                rdm{i_subject}{i_session}.order   = {x.order};
                rdm{i_subject}{i_session}.onset   = {x.onset};
                rdm{i_subject}{i_session}.name    = {x.name};
                [x,y] = deal(x(ix),x(iy));
                ii = (~arrayfun(scan.job.model(i_model).filter,x,y));
                rdm{i_subject}{i_session}.filter  = ~ii;
                rdm{i_subject}{i_session}.rdm     = nan(size(ii));
                rdm{i_subject}{i_session}.rdm(ii) = double(arrayfun(scan.job.model(i_model).function,x(ii),y(ii)));
            end
            
            % wait
            scan = scan_tool_progress(scan,[]);
        end
        
        % save
        scan.running.model(i_model).rdm = rdm;
    end
    scan = scan_tool_progress(scan,0);
end
