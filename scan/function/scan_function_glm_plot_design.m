
function scan = scan_function_glm_plot_design(scan)
    %% scan = SCAN_FUNCTION_GLM_PLOT_DESIGN(scan)
    % define function @plot.design
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    if ~scan.running.flag.design,   return; end
    scan.function.plot.design = @auxiliar_design;
end

%% auxiliar
function auxiliar_design(varargin)
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=2 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@plot.design(scan,subject)','This function opens the SPM Design Report (spm_DesRep) interface for the participant [subject]. You can use it to see the design matrix, the covariation between regressors');
        return;
    end
    SPM = file_loadvar(fullfile(tcan.running.directory.copy.first.spm,sprintf('subject_%03i',varargin{2}),'SPM.mat'),'SPM');
    spm_DesRep('DesRepUI',SPM);
end
