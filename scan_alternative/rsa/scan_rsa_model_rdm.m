
function scan = scan_rsa_model_rdm(scan)
    %% scan = SCAN_RSA_MODEL_RDM(scan)
    % build RDMs for the model
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.model, return; end
    
    % variables
    x_subject = scan.running.load.subject;
    x_session = scan.running.load.session;
        
    % build RDMs
    scan_tool_progress(scan,length(scan.job.model) * scan.running.subject.number);
    for i_model = 1:length(scan.job.model)
        rdm = cell(1,scan.running.subject.number);
        
        % subject
        for i_subject = 1:scan.running.subject.number
            ii_subject = (x_subject == i_subject);
            
            % session
            rdm{i_subject} = cell(1,scan.running.subject.session(i_subject));
            for i_session = 1:scan.running.subject.session(i_subject)
                ii_session = (x_session == i_session);
        
                % build a big RDM
                x = mat2vec(scan.running.model(i_model).column(ii_subject & ii_session));
                [ix,iy] = meshgrid(1:length(x),1:length(x));
                ix = tril(ix); ix(~ix) = [];
                iy = tril(iy); iy(~iy) = [];
                rdm{i_subject}{i_session} = arrayfun(scan.job.model(i_model).function,x(ix),x(iy));
            end
            
            % wait
            scan_tool_progress(scan,[]);
        end
        
        % save
        scan.running.model(i_model).rdm = rdm;
    end
    scan_tool_progress(scan,0);
        
%         scan.running.model{i_subject}{i_session}(i_model).vector = double(squareform(
end
