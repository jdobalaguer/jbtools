
function [scan,job] = scan_preprocess_remove(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_REMOVE(scan,job)
    % remove preprocessed data
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<>

    %% FUNCTION
    for i_subject = scan.subject.u
        nb_runs     = job.run(i_subject);
        u_run       = 1:nb_runs;
        for i_run = u_run
            if nb_runs==1,  dir_from = strcat(sprintf(job.from.path,i_subject));
            else            dir_from = strcat(sprintf(job.from.path,i_subject,i_run));
            end
            fprintf('Remove folder : subject %02i : run %d \n',i_subject,i_run);
            rmdir(dir_from,'s');
        end
    end
end
