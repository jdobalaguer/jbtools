
function scan = scan_function_rsa_get_rdm(scan)
    %% scan = SCAN_FUNCTION_RSA_GET_RDM(scan)
    % define function @get.rdm
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.get.rdm = @auxiliar_rdm;

end

%% auxiliar
function varargout = auxiliar_rdm(varargin)
    varargout = {};
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=4 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@model(scan,i_subject,i_session,mask)','This function gets the RDM within a mask.');
        return;
    end
    
    % default
    [i_subject,i_session,mask] = varargin{2:4};
    
    % mask & beta
    mask = logical(scan_nifti_load(fullfile(tcan.directory.mask,mask)));
    beta = scan_tool_rsa_fMRIDataPreparation(tcan,tcan.running.subject.unique(i_subject),tcan.running.subject.session{i_subject}(i_session));
    beta = beta(mask,:)';
    
    % whitening
    if tcan.job.whitening
        R = getResiduals(tcan,i_subject,mask);
        beta = scan_tool_rsa_whitening(tcan,beta,R,i_subject,i_session);
    end
    
    % get RDM
    rdm  = scan_tool_rsa_buildrdm(tcan,beta,i_subject,i_session);
    
    % retugn
    varargout = {rdm};
end

%% auxiliar: getResiduals
function R = getResiduals(scan,i_subject,mask)
    R = {};
    if ~scan.job.whitening, return; end
    R = scan_nifti_load(scan.running.glm.running.file.residual.volumes{i_subject},mask);
    R = cat(2,R{:})';
    u_session = unique(scan.running.glm.running.subject.session{i_subject});
    R = mat2cell(R,arrayfun(@(s)sum(scan.running.glm.running.design(i_subject).row.session==s),u_session),size(R,2));
end

