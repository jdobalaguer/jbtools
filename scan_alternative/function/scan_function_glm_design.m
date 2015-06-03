
function scan = scan_function_glm_design(scan)
    %% scan = SCAN_FUNCTION_GLM_DESIGN(scan)
    % define "design" function
    % to list main functions, try
    %   >> help scan;

    %% function
    scan_tool_print(scan,false,'\nAdd function (design) : ');
    scan.function.design = @auxiliar_design;
    
    %% nested
    function auxiliar_design(subject)
        SPM = file_loadvar(fullfile(scan.running.directory.copy.first.spm,sprintf('subject_%03i',subject),'SPM.mat'),'SPM');
        spm_DesRep('DesRepUI',SPM);
    end
end


