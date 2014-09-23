
function scan = scan_glm_copy_beta1(scan)
    %% SCAN_GLM_COPY_BETA()
    % copy first level beta files into a new folder
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('glm copy betas for :       subject %02i \n',subject);
        for i_contrast = 1:length(scan.glm.contrast{i_subject})
            dire_firstlevel = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,subject);
            dire_beta1      = sprintf('%s/',  scan.dire.glm.beta1,scan.glm.contrast{i_subject}{i_contrast}.name);
            mkdirp(dire_beta1);
            if exist(sprintf('%sbeta_%04i.hdr',dire_firstlevel,i_contrast),'file'), copyfile(sprintf('%sbeta_%04i.hdr',dire_firstlevel,i_contrast),sprintf('%sbeta_sub%02i_con%02i.hdr',dire_beta1,subject,i_contrast)); end
            if exist(sprintf('%sbeta_%04i.img',dire_firstlevel,i_contrast),'file'), copyfile(sprintf('%sbeta_%04i.img',dire_firstlevel,i_contrast),sprintf('%sbeta_sub%02i_con%02i.img',dire_beta1,subject,i_contrast)); end
            if exist(sprintf('%sbeta_%04i.nii',dire_firstlevel,i_contrast),'file'), copyfile(sprintf('%sbeta_%04i.nii',dire_firstlevel,i_contrast),sprintf('%sbeta_sub%02i_con%02i.nii',dire_beta1,subject,i_contrast)); end
        end
    end
    
end
