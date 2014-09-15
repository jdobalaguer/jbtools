
function scan = scan_glm_copy_statistic1(scan)
    %% SCAN_GLM_COPY_STATISTIC1()
    % copy first level t-statistic files into a new folder
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<>
    
    %% FUNCTION
    for subject = scan.subject.u
        fprintf('glm copy statistic1 for :  subject %02i \n',subject);
        for i_con = 1:length(scan.glm.contrast)
            dire_firstlevel = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,subject);
            dire_statistic1 = sprintf('%s%s/',  scan.dire.glm.statistic1,scan.glm.contrast{i_con}.name);
            mkdirp(dire_statistic1);
            if exist(sprintf('%sspmT_%04i.hdr',dire_firstlevel,i_con),'file'), copyfile(sprintf('%sspmT_%04i.hdr',dire_firstlevel,i_con),sprintf('%sspmT_sub%02i_con%02i.hdr',dire_statistic1,subject,i_con)); end
            if exist(sprintf('%sspmT_%04i.img',dire_firstlevel,i_con),'file'), copyfile(sprintf('%sspmT_%04i.img',dire_firstlevel,i_con),sprintf('%sspmT_sub%02i_con%02i.img',dire_statistic1,subject,i_con)); end
            if exist(sprintf('%sspmT_%04i.nii',dire_firstlevel,i_con),'file'), copyfile(sprintf('%sspmT_%04i.nii',dire_firstlevel,i_con),sprintf('%sspmT_sub%02i_con%02i.nii',dire_statistic1,subject,i_con)); end
        end
    end
    
end
