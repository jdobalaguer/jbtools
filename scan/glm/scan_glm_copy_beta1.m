
function scan = scan_glm_copy_beta1(scan)
    %% SCAN_GLM_COPY_BETA()
    % copy first level beta files into a new folder
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    for subject = scan.subject.u
        fprintf('glm copy betas for :       subject %02i \n',subject);
        for i_con = 1:length(scan.glm.contrast)
            dire_firstlevel = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,subject);
            dire_beta       = sprintf('%s/',  scan.dire.glm.beta1,scan.glm.contrast{i_con}.name);
            mkdirp(dire_beta);
            if exist(sprintf('%sbeta_%04i.hdr',dire_firstlevel,i_con),'file'), copyfile(sprintf('%sbeta_%04i.hdr',dire_firstlevel,i_con),sprintf('%sbeta_sub%02i_con%02i.hdr',dire_beta,subject,i_con)); end
            if exist(sprintf('%sbeta_%04i.img',dire_firstlevel,i_con),'file'), copyfile(sprintf('%sbeta_%04i.img',dire_firstlevel,i_con),sprintf('%sbeta_sub%02i_con%02i.img',dire_beta,subject,i_con)); end
            if exist(sprintf('%sbeta_%04i.nii',dire_firstlevel,i_con),'file'), copyfile(sprintf('%sbeta_%04i.nii',dire_firstlevel,i_con),sprintf('%sbeta_sub%02i_con%02i.nii',dire_beta,subject,i_con)); end
        end
    end
    
end
