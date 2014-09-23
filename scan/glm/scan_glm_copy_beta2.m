
function scan = scan_glm_copy_beta2(scan)
    %% SCAN3_GLM_COPY_BETA2()
    % copy second level beta files into a new folder
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% COPY CONTRASTS
    warning('TO FIX INMEDIATELY');
            
    mkdirp(scan.dire.glm.beta2);
    for i_con = 1:length(scan.glm.contrast{1})
        fprintf('glm copy beta2 for :       contrast "%s" \n',scan.glm.contrast{1}{i_con}.name);
        img_from = sprintf('%s%s/beta_0001.img',scan.dire.glm.secondlevel,scan.glm.contrast{1}{i_con}.name);
        img_to   = sprintf('%s/beta_%s.img',scan.dire.glm.beta2,scan.glm.contrast{1}{i_con}.name);
        if exist(img_from,'file'), copyfile(img_from,img_to); end
        hdr_from = sprintf('%s%s/beta_0001.hdr',scan.dire.glm.secondlevel,scan.glm.contrast{1}{i_con}.name);
        hdr_to   = sprintf('%s/beta_%s.hdr',scan.dire.glm.beta2,scan.glm.contrast{1}{i_con}.name);
        if exist(hdr_from,'file'), copyfile(hdr_from,hdr_to); end
        nii_from = sprintf('%s%s/beta_0001.nii',scan.dire.glm.secondlevel,scan.glm.contrast{1}{i_con}.name);
        nii_to   = sprintf('%s/beta_%s.nii',scan.dire.glm.beta2,scan.glm.contrast{1}{i_con}.name);
        if exist(nii_from,'file'), copyfile(nii_from,nii_to); end
    end
    
end