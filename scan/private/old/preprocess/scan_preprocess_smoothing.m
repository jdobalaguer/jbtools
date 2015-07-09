
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
        nb_runs     = job.run(i_subject);
        u_run       = 1:nb_runs;
        
        batch = struct();
        batch.spm.spatial.smooth.fwhm = [8 8 8];
        batch.spm.spatial.smooth.dtype = 0;
        batch.spm.spatial.smooth.im = 0;
        batch.spm.spatial.smooth.prefix = 's';
        file_from = {};
        for i_run = u_run
            fprintf('Smoothing : subject %02i : run %d \n',i_subject,i_run);
            if nb_runs==1,  dir_from = strcat(sprintf(job.from.path,i_subject),filesep);
            else            dir_from = strcat(sprintf(job.from.path,i_subject,i_run),filesep);
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
