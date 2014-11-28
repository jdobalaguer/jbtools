
function [scan,job] = scan_preprocess_despike(scan,job)
    %% scan = SCAN_PREPROCESS_DESPIKE(scan)
    % preprocessing spike correction
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<*FPARK>

    %% FUNCTION
    
    % assert
    assert(logical(exist('art_slice.m','file')),'scan_preprocess_despike: error. no ART toolbox');
    
    % despike
    for i_subject = scan.subject.u
        nb_runs     = job.run(i_subject);
        u_run       = 1:nb_runs;
        for i_run = u_run
            fprintf('Spike correction : subject %02i : run %d \n',i_subject,i_run);
            if nb_runs==1,  dir_from = strcat(sprintf(job.from.path,i_subject),filesep);
            else            dir_from = strcat(sprintf(job.from.path,i_subject,i_run),filesep);
            end
            run_images = dir([dir_from,job.from.file]);
            run_images = strvcat(run_images.name);
            filenames  = strcat(dir_from,run_images);
            art_slice(filenames);
        end
    end
end
