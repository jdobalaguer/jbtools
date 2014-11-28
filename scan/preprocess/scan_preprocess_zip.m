
function [scan,job] = scan_preprocess_zip(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_ZIP(scan,job)
    % zip preprocessed data
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
            fprintf('ZIP folder : subject %02i : run %d \n',i_subject,i_run);
            if(dir_from(end)==filesep), dir_from(end) = []; end
            zip_from = [dir_from,'.zip'];
            dir_from = [dir_from,filesep];
            zip(zip_from,dir_from);
        end
    end
end
