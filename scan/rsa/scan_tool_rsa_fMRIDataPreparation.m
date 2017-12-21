
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
end
