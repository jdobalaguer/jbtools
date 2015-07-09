
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
    mask = scan_nifti_load(fullfile(tcan.directory.mask,mask));
    beta = scan_tool_rsa_fMRIDataPreparation(tcan,i_subject,i_session);
    mask = mask & all(beta,2) & all(~isnan(beta),2);
    beta = beta(mask,:);
    
    % get RDM
    rdm  = scan_tool_rsa_buildrdm(tcan,beta');
    
    % retugn
    varargout = {rdm};
end
