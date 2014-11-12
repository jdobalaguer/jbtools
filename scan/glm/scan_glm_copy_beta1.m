
function scan = scan_glm_copy_beta1(scan)
    %% SCAN_GLM_COPY_BETA()
    % copy first level beta files into a new folder
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('glm copy betas for :       subject %02i \n',subject);
        
        % get regressors
        u_regressor = {};
        for i_regressor = 1:length(scan.glm.regressor)
            u_regressor = [u_regressor, {scan.glm.regressor(i_regressor).name}, scan.glm.regressor(i_regressor).subname];
        end
        n_regressor = length(u_regressor);

        % get order
        switch(scan.glm.function)
            case 'hrf', n_order = 1+sum(scan.glm.hrf.ord);
            case 'fir', n_order = scan.glm.fir.ord;
        end
        
        j_regressor = 0;
        for i_regressor = 1:n_regressor
            for i_order = 1:n_order
                j_regressor = j_regressor + 1;
                dire_firstlevel = sprintf('%ssub_%02i/', scan.dire.glm.firstlevel,subject);
                dire_beta1      = sprintf('%s%s_%03i/',  scan.dire.glm.beta1,u_regressor{i_regressor},i_order);
                mkdirp(dire_beta1);
                if exist(sprintf('%sbeta_%04i.hdr',dire_firstlevel,j_regressor),'file'), copyfile(sprintf('%sbeta_%04i.hdr',dire_firstlevel,j_regressor),sprintf('%sbeta_sub%02i_reg%02i.hdr',dire_beta1,subject,j_regressor)); end
                if exist(sprintf('%sbeta_%04i.img',dire_firstlevel,j_regressor),'file'), copyfile(sprintf('%sbeta_%04i.img',dire_firstlevel,j_regressor),sprintf('%sbeta_sub%02i_reg%02i.img',dire_beta1,subject,j_regressor)); end
                if exist(sprintf('%sbeta_%04i.nii',dire_firstlevel,j_regressor),'file'), copyfile(sprintf('%sbeta_%04i.nii',dire_firstlevel,j_regressor),sprintf('%sbeta_sub%02i_reg%02i.nii',dire_beta1,subject,j_regressor)); end
            end
        end
    end
    
end
