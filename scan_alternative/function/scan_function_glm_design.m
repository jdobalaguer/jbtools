
function scan = scan_function_glm_design(scan)
    %% scan = SCAN_FUNCTION_GLM_DESIGN(scan)
    % define "design" function
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    if ~scan.running.flag.design,   return; end
    
    scan_tool_print(scan,false,'\nAdd function (design) : ');
    scan.function.design = @auxiliar_design;
    
    %% nested
    function auxiliar_design(varargin)
        if nargin~=1 || strcmp(varargin{1},'help')
            scan_tool_help('@design(subject)','This function opens the SPM Design Report (spm_DesRep) interface for the participant [subject]. You can use it to see the design matrix, the covariation between regressors');
            return;
        end
        SPM = file_loadvar(fullfile(scan.running.directory.copy.first.spm,sprintf('subject_%03i',scan.running.subject.unique(varargin{1})),'SPM.mat'),'SPM');
        spm_DesRep('DesRepUI',SPM);
    end
end
