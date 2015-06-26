
function betaCorrespondence = scan_tool_rsa_betaCorrespondence(scan,i_session)
    %% betaCorrespondence = SCAN_TOOL_RSA_BETACORRESPONDENCE(scan,i_session)
    % RSA toolbox - create betaCorrespondence
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % this is wrong when using the concatenation!!!
    scan_tool_assert(scan,~scan.job.concatSessions,'this doesnt work with the concatenation (fix-me-please)');    
    
    %% function
    betaCorrespondence = struct('identifier',{});
    if ~scan.running.flag.toolbox, return; end
    
    betaCorrespondence = mat2row(cellfun(@(s)struct('identifier',fullfile(s,sprintf('[[subjectName]] session_%03i order_001.nii',i_session))),strcat(scan.running.load.name,scan.running.load.version)));
    
end