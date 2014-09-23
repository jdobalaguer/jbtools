
function scan = scan_glm_copy_contrast1(scan)
    %% SCAN_GLM_COPY_CONTRAST1()
    % copy first level contrast files into a new folder
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('glm copy contrast1 for :   subject %02i \n',subject);
        for i_contrast = 1:length(scan.glm.contrast{i_subject})
            dire_firstlevel = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,subject);
            dire_contrast1  = sprintf('%s%s/',  scan.dire.glm.contrast1,scan.glm.contrast{i_subject}{i_contrast}.name);
            mkdirp(dire_contrast1);
            if exist(sprintf('%scon_%04i.hdr',dire_firstlevel,i_contrast),'file'), copyfile(sprintf('%scon_%04i.hdr',dire_firstlevel,i_contrast),sprintf('%scont_sub%02i_con%02i.hdr',dire_contrast1,subject,i_contrast)); end
            if exist(sprintf('%scon_%04i.img',dire_firstlevel,i_contrast),'file'), copyfile(sprintf('%scon_%04i.img',dire_firstlevel,i_contrast),sprintf('%scont_sub%02i_con%02i.img',dire_contrast1,subject,i_contrast)); end
            if exist(sprintf('%scon_%04i.nii',dire_firstlevel,i_contrast),'file'), copyfile(sprintf('%scon_%04i.nii',dire_firstlevel,i_contrast),sprintf('%scont_sub%02i_con%02i.nii',dire_contrast1,subject,i_contrast)); end
        end
    end
    
end
