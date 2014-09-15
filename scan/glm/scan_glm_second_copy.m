
function scan = scan_glm_second_copy(scan)
    %% SCAN_GLM_SECOND_COPY()
    % copy files to the second level folder
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% FUNCTION
    for i_sub = scan.subject.u
        fprintf('glm second level copy for: subject %02i\n',i_sub);
        for i_con = 1:length(scan.glm.contrast)
            dir_datglm1 = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,i_sub);
            dir_datglm2 = sprintf('%s%s/',scan.dire.glm.secondlevel,scan.glm.contrast{i_con}.name);
            if ~exist(dir_datglm2,'dir'); mkdirp(dir_datglm2); end
            if exist(sprintf('%sspmT_%04i.hdr',dir_datglm1,i_con),'file'), copyfile(sprintf('%sspmT_%04i.hdr',dir_datglm1,i_con),sprintf('%sspmT_sub%02i_con%02i.hdr',dir_datglm2,i_sub,i_con)); end
            if exist(sprintf('%sspmT_%04i.img',dir_datglm1,i_con),'file'), copyfile(sprintf('%sspmT_%04i.img',dir_datglm1,i_con),sprintf('%sspmT_sub%02i_con%02i.img',dir_datglm2,i_sub,i_con)); end
            if exist(sprintf('%sspmT_%04i.nii',dir_datglm1,i_con),'file'), copyfile(sprintf('%sspmT_%04i.nii',dir_datglm1,i_con),sprintf('%sspmT_sub%02i_con%02i.nii',dir_datglm2,i_sub,i_con)); end
            if exist(sprintf('%scon_%04i.hdr', dir_datglm1,i_con),'file'), copyfile(sprintf('%scon_%04i.hdr', dir_datglm1,i_con),sprintf('%scon_sub%02i_con%02i.hdr' ,dir_datglm2,i_sub,i_con)); end
            if exist(sprintf('%scon_%04i.img', dir_datglm1,i_con),'file'), copyfile(sprintf('%scon_%04i.img', dir_datglm1,i_con),sprintf('%scon_sub%02i_con%02i.img' ,dir_datglm2,i_sub,i_con)); end
            if exist(sprintf('%scon_%04i.nii', dir_datglm1,i_con),'file'), copyfile(sprintf('%scon_%04i.nii', dir_datglm1,i_con),sprintf('%scon_sub%02i_con%02i.nii' ,dir_datglm2,i_sub,i_con)); end
        end
    end
    
end
