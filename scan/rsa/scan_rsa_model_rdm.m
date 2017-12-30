
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
            ii_subject = (x_subject == scan.running.subject.unique(i_subject));
            
            % concatenation
            [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
            if scan.job.concatSessions, n_session = 1; end
            rdm{i_subject} = cell(1,n_session);
            
            % session
            for i_session = 1:n_session
                ii_session = (x_session == u_session(i_session));
                
                % concatenation
                if scan.job.concatSessions, ii_session(:) = 1; end
        
                % build a model RDM
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
                rdm{i_subject}{i_session}.rdm     = nan(size(ii),'single');
                rdm{i_subject}{i_session}.rdm(ii) = single(arrayfun(scan.job.model(i_model).function,x(ii),y(ii)));
                
                if scan.job.padSessions, rdm{i_subject}{i_session} = padSession(scan,rdm{i_subject}{i_session},i_subject); end
            end
            
            % wait
            scan = scan_tool_progress(scan,[]);
        end
        
        % save
        scan.running.model(i_model).rdm = rdm;
    end
    scan = scan_tool_progress(scan,0);
end

%% auxiliar
function rdm = padSession(scan,rdm,i_subject)

    % assert
    scan_tool_assert(scan,scan.job.concatSessions,'[scan.job.padSessions] is only allowed with [scan.job.concatSessions]');
    scan_tool_assert(scan,isscalar(unique([rdm.order{:}])),'[scan.job.padSessions] is only works with columns from a single order');
    
    % columns
    s_name = scan.job.glm.condition;
    n_name = length(s_name);
    x_name = cellfun(@(s)strcmp(scan.running.load.name,s),scan.job.glm.condition,'UniformOutput',false);
    x_name = cat(2,x_name{:});
    x_name = sum(x_name .* (1:n_name),2);
    x_session    = scan.running.load.session;
    [z_rows,~,~] = unique([x_session,x_name],'rows');
    z_session = z_rows(:,1);
    z_name    = z_rows(:,2);
    n_rows = size(z_rows,1);

    % get padded RDM and filter
    ii_subject = (scan.running.load.subject == scan.running.subject.unique(i_subject));
    ii_rdm     = ismember(z_rows,[x_session(ii_subject),x_name(ii_subject)],'rows');
    m_rdm                   = nan(n_rows,n_rows);
    m_filter                = true(n_rows,n_rows);
    m_rdm(ii_rdm,ii_rdm)    = squareform(rdm.rdm);
    m_filter(ii_rdm,ii_rdm) = squareform(rdm.filter);
    m_rdm                   = m_rdm(tril(squareform(true(1,0.5 * n_rows * (n_rows-1)))));
    m_filter                = m_filter(tril(squareform(true(1,0.5 * n_rows * (n_rows-1)))));
    
    % save other things
    rdm.subject = repmat({scan.running.subject.unique(i_subject)},[1,n_rows]);
    rdm.session = num2cell(z_session');
    rdm.order   = repmat({unique([rdm.order{:}])},[1,n_rows]);
    rdm.onset   = repmat({nan},[1,n_rows]);
    rdm.name    = s_name(z_name');
    rdm.filter  = m_filter;
    rdm.rdm     = m_rdm;
end
