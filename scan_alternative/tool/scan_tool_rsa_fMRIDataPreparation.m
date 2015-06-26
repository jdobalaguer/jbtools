
function singleSubjectVols = scan_tool_rsa_fMRIDataPreparation(scan,i_subject,i_session)
    %% singleSubjectVols = SCAN_TOOL_RSA_FMRIDATAPREPARATION(scan,i_subject,i_session)
    % RSA toolbox - fMRIDataPreparation
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    ii_subject = (scan.running.load.subject == i_subject);
    ii_session = (scan.running.load.session == i_session);
    if scan.job.concatSessions, ii_session(:) = 1; end
    singleSubjectVols = scan.running.load.beta(ii_subject & ii_session,:)';
%     singleSubjectVols = nan2zero(singleSubjectVols);
end
