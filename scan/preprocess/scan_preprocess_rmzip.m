
function [scan,job] = scan_preprocess_rmzip(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_RMZIP(scan,job)
    % remove preprocessed data
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<>

    %% FUNCTION
    for i_subject = scan.subject.u
        dir_sub  = strtrim(scan.dire.nii.subs(i_subject,:));
        dir_runs    = dir([strtrim(scan.dire.nii.epi3(i_subject,:)),'run*']); dir_runs = strcat(strvcat(dir_runs.name),filesep);
        nb_runs     = size(dir_runs, 1);
        u_run       = 1:nb_runs;
        if ~job.run, u_run = 1; end
        for i_run = u_run
            if job.run, dir_from = strcat(dir_sub,sprintf(job.from.path,i_run));
            else        dir_from = strcat(dir_sub,job.from.path);
            end
            zip_from = [dir_from,'.zip'];
            fprintf('Remove ZIP :                     %s\n',zip_from);
            delete(zip_from);
        end
    end
end
