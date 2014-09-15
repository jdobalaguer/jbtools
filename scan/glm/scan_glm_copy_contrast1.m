
function scan = scan_glm_copy_contrast1(scan)
    %% SCAN_GLM_COPY_CONTRAST1()
    % copy first level contrast files into a new folder
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    for subject = scan.subject.u
        fprintf('glm copy contrast1 for :   subject %02i \n',subject);
        for i_con = 1:length(scan.glm.contrast)
            dire_firstlevel = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,subject);
            dire_contrast1  = sprintf('%s%s/',  scan.dire.glm.contrast1,scan.glm.contrast{i_con}.name);
            mkdirp(dire_contrast1);
            if exist(sprintf('%scon_%04i.hdr',dire_firstlevel,i_con),'file'), copyfile(sprintf('%scon_%04i.hdr',dire_firstlevel,i_con),sprintf('%scont_sub%02i_con%02i.hdr',dire_contrast1,subject,i_con)); end
            if exist(sprintf('%scon_%04i.img',dire_firstlevel,i_con),'file'), copyfile(sprintf('%scon_%04i.img',dire_firstlevel,i_con),sprintf('%scont_sub%02i_con%02i.img',dire_contrast1,subject,i_con)); end
            if exist(sprintf('%scon_%04i.nii',dire_firstlevel,i_con),'file'), copyfile(sprintf('%scon_%04i.nii',dire_firstlevel,i_con),sprintf('%scont_sub%02i_con%02i.nii',dire_contrast1,subject,i_con)); end
        end
    end
    
end
