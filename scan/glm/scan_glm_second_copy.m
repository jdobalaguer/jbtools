
function scan = scan_glm_second_copy(scan)
    %% SCAN_GLM_SECOND_COPY()
    % copy files to the second level folder
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('glm second level copy for: subject %02i\n',subject);
        for i_contrast = 1:length(scan.glm.contrast{i_subject})
            dir_datglm1 = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,subject);
            dir_datglm2 = sprintf('%s%s/',scan.dire.glm.secondlevel,scan.glm.contrast{i_subject}{i_contrast}.name);
            if ~exist(dir_datglm2,'dir'); mkdirp(dir_datglm2); end
            if exist(sprintf('%sspmT_%04i.hdr',dir_datglm1,i_contrast),'file'), copyfile(sprintf('%sspmT_%04i.hdr',dir_datglm1,i_contrast),sprintf('%sspmT_sub%02i_con%02i.hdr',dir_datglm2,subject,i_contrast)); end
            if exist(sprintf('%sspmT_%04i.img',dir_datglm1,i_contrast),'file'), copyfile(sprintf('%sspmT_%04i.img',dir_datglm1,i_contrast),sprintf('%sspmT_sub%02i_con%02i.img',dir_datglm2,subject,i_contrast)); end
            if exist(sprintf('%sspmT_%04i.nii',dir_datglm1,i_contrast),'file'), copyfile(sprintf('%sspmT_%04i.nii',dir_datglm1,i_contrast),sprintf('%sspmT_sub%02i_con%02i.nii',dir_datglm2,subject,i_contrast)); end
            if exist(sprintf('%scon_%04i.hdr', dir_datglm1,i_contrast),'file'), copyfile(sprintf('%scon_%04i.hdr', dir_datglm1,i_contrast),sprintf('%scon_sub%02i_con%02i.hdr' ,dir_datglm2,subject,i_contrast)); end
            if exist(sprintf('%scon_%04i.img', dir_datglm1,i_contrast),'file'), copyfile(sprintf('%scon_%04i.img', dir_datglm1,i_contrast),sprintf('%scon_sub%02i_con%02i.img' ,dir_datglm2,subject,i_contrast)); end
            if exist(sprintf('%scon_%04i.nii', dir_datglm1,i_contrast),'file'), copyfile(sprintf('%scon_%04i.nii', dir_datglm1,i_contrast),sprintf('%scon_sub%02i_con%02i.nii' ,dir_datglm2,subject,i_contrast)); end
        end
    end
    
end
