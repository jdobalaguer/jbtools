
function scan = scan_glm_copy_contrast2(scan)
    %% SCAN_GLM_COPY_CONTRAST2()
    % copy second level contrast files into a new folder
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED>
    
    %% COPY CONTRASTS
    mkdirp(scan.dire.glm.contrast2);
    for i_con = 1:length(scan.glm.contrast{1})
        fprintf('glm copy contrast2 for :   contrast "%s" \n',scan.glm.contrast{1}{i_con}.name);
        img_from = sprintf('%s%s/con_0001.img',scan.dire.glm.secondlevel,scan.glm.contrast{1}{i_con}.name);
        img_to   = sprintf('%s/cont_%s.img',scan.dire.glm.contrast2,scan.glm.contrast{1}{i_con}.name);
        if exist(img_from,'file'), copyfile(img_from,img_to); end
        hdr_from = sprintf('%s%s/con_0001.hdr',scan.dire.glm.secondlevel,scan.glm.contrast{1}{i_con}.name);
        hdr_to   = sprintf('%s/cont_%s.hdr',scan.dire.glm.contrast2,scan.glm.contrast{1}{i_con}.name);
        if exist(hdr_from,'file'), copyfile(hdr_from,hdr_to); end
        nii_from = sprintf('%s%s/con_0001.nii',scan.dire.glm.secondlevel,scan.glm.contrast{1}{i_con}.name);
        nii_to   = sprintf('%s/cont_%s.nii',scan.dire.glm.contrast2,scan.glm.contrast{1}{i_con}.name);
        if exist(nii_from,'file'), copyfile(nii_from,nii_to); end
    end
    
end