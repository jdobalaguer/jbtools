
function [scan,job] = scan_preprocess_smoothing(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_SMOOTHING(scan,job)
    % preprocessing smoothing
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<*FPARK,*AGROW>
    
    %% FUNCTION
    % function smoothing(df,dt,prefix)
    batches = {};
    for i_subject = scan.subject.u
        dir_sub  = strtrim(scan.dire.nii.subs(i_subject,:));
        dir_runs = dir([strtrim(scan.dire.nii.epi3(i_subject,:)),'run*']);
        dir_runs = strcat(strvcat(dir_runs.name),filesep);
        nb_runs  = size(dir_runs, 1);
        u_run    = 1:nb_runs;
        if ~job.run, u_run = 1; end
        fprintf('Smoothing for:                   %s\n',dir_sub);
        batch = struct();
        batch.spm.spatial.smooth.fwhm = [8 8 8];
        batch.spm.spatial.smooth.dtype = 0;
        batch.spm.spatial.smooth.im = 0;
        batch.spm.spatial.smooth.prefix = 's';
        file_from = {};
        for i_run = u_run
            if job.run, dir_from = strcat(dir_sub,sprintf(job.from.path,i_run),filesep);
            else        dir_from = strcat(dir_sub,job.from.path,filesep);
            end
            run_images = dir([dir_from,job.from.file]);
            run_images = strvcat(run_images.name);
            file_from{i_run} = strcat(dir_from,run_images);
        end
        batch.spm.spatial.smooth.data = cellstr(strvcat(file_from));
        batches{end+1} = batch;
    end
    if ~isempty(batches)
        spm_jobman('run',batches);
    end
end
