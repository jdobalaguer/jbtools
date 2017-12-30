
function singleSubjectVols = scan_tool_rsa_fMRIDataPreparation(scan,subject,session)
    %% singleSubjectVols = SCAN_TOOL_RSA_FMRIDATAPREPARATION(scan,subject,session)
    % RSA toolbox - fMRIDataPreparation
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    ii_subject = (scan.running.load.subject == subject);
    ii_session = (scan.running.load.session == session);
    if scan.job.concatSessions, ii_session(:) = 1; end
    singleSubjectVols = scan.running.load.beta(ii_subject & ii_session,:)';
    
    % padding
    if scan.job.padSessions, singleSubjectVols = padSession(scan,singleSubjectVols,subject); end
end

%% auxiliar
function m_beta = padSession(scan,beta,subject)
    % assert
    scan_tool_assert(scan,scan.job.concatSessions,'[scan.job.padSessions] is only allowed with [scan.job.concatSessions]');
    
    % columns
    s_name = scan.job.glm.condition;
    n_name = length(s_name);
    x_name = cellfun(@(s)strcmp(scan.running.load.name,s),scan.job.glm.condition,'UniformOutput',false);
    x_name = cat(2,x_name{:});
    x_name = sum(x_name .* (1:n_name),2);
    x_session    = scan.running.load.session;
    [z_rows,~,~] = unique([x_session,x_name],'rows');
    n_rows = size(z_rows,1);

    % get padded RDM and filter
    ii_subject = (scan.running.load.subject == subject);
    ii_beta    = ismember(z_rows,[x_session(ii_subject),x_name(ii_subject)],'rows');
    m_beta            = nan(size(beta,1),n_rows,class(beta));
    m_beta(:,ii_beta) = beta;
end
