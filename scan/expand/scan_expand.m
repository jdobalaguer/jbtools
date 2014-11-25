
function scan = scan_expand(scan)
    %% scan = SCAN_EXPAND(scan)
    % expand all 4d files into multiple 3d files
    % see also scan_dcm2nii
    %          scan_preprocess
    
    %% WARNINGS
    %#ok<>

    %% FUNCTION
    for i_sub = scan.subject.u
        dir_sub  = strtrim(scan.dire.nii.subs(i_sub,:));
        dir_epi3 = strtrim(scan.dire.nii.epi3(i_sub,:));
        dir_epi4 = strtrim(scan.dire.nii.epi4(i_sub,:));
        file_epis4 = dir([dir_epi4,'images*.nii']);
        fprintf('Expand for:                      %s\n',dir_sub);
        for i_run = 1:length(file_epis4)
            dir_run   = sprintf('%srun%d/',dir_epi3,i_run);
            mkdirp(dir_run);
            dir_img   = strcat(dir_run,'images',filesep);
            mkdirp(dir_img);
            file_epi4 = strcat(dir_epi4,file_epis4(i_run).name);
            if isempty(dir([dir_img,'images*.nii']))
                spm_file_split(file_epi4,dir_img);
            end
        end
    end
end