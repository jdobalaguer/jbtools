
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
        dir_sub  = strtrim(scan.dire.nii.subs(i_subject,:));
        dir_runs    = dir([strtrim(scan.dire.nii.epi3(i_subject,:)),'run*']); dir_runs = strcat(strvcat(dir_runs.name),filesep);
        nb_runs     = size(dir_runs, 1);
        u_run       = 1:nb_runs;
        if ~job.run, u_run = 1; end
        fprintf('Spike correction for:            %s\n',dir_sub);
        for i_run = u_run
            if job.run, dir_from = strcat(dir_sub,sprintf(job.from.path,i_run),filesep);
            else        dir_from = strcat(dir_sub,job.from.path,filesep);
            end
            run_images = dir([dir_from,job.from.file]);
            run_images = strvcat(run_images.name);
            filenames  = strcat(dir_from,run_images);
            art_slice(filenames);
        end
    end
end
