
function [scan,job] = scan_preprocess_remove(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_REMOVE(scan,job)
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
            if job.run, dir_from = strcat(dir_sub,sprintf(job.from.path,i_run),filesep);
            else        dir_from = strcat(dir_sub,job.from.path,filesep);
            end
            if ~isfield(job.from,'file') || isempty(job.from.file)
                rmdir(dir_from,'s');
            end
        end
    end
end
