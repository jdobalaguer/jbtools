
function scan = scan_rsa_beta(scan)
    scan.rsa.beta = [];
    error('scan_rsa_beta: error. todo..');
    
    for session = 1
        for condition = 1:size(betas,2)
            betas(session,condition).identifier = [preBeta betas(session,condition).identifier postBeta];
        end%for
    end%for

%     for i_regressor = 1:length(scan.rsa.regressor)
%         [scan.dire.glm.beta1,scan.rsa.regressor{i_regressor},'_001',filesep];
%     end
end