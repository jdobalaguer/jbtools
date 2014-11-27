
function [scan,job] = scan_preprocess_slicetiming(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_SLICETIMING(scan,job)
    % preprocessing slice timing
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<*FPARK,*AGROW>

    %% FUNCTION
    
    % slice timing
    batches = {};
    for i_subject = scan.subject.u
        dir_sub  = strtrim(scan.dire.nii.subs(i_subject,:));
        dir_runs    = dir([strtrim(scan.dire.nii.epi3(i_subject,:)),'run*']); dir_runs = strcat(strvcat(dir_runs.name),filesep);
        nb_runs     = size(dir_runs, 1);
        u_run       = 1:nb_runs;
        if ~job.run, u_run = 1; end
        fprintf('Slice-Timing for:                %s\n',dir_sub);
        batch = struct();
        batch.spm.temporal.st.nslices = pars_nslices;
        batch.spm.temporal.st.tr = pars_tr;
        batch.spm.temporal.st.ta = pars_tr - (pars_tr/pars_nslices);
        batch.spm.temporal.st.so = pars_ordsl;
        batch.spm.temporal.st.refslice = pars_refsl;
        batch.spm.temporal.st.prefix = 'a';
        for i_run = u_run
            if job.run, dir_from = strcat(dir_sub,sprintf(job.from.path,i_run),filesep);
            else        dir_from = strcat(dir_sub,job.from.path,filesep);
            end
            run_images = dir([dir_from,job.from.file]);
            run_images = strvcat(run_images.name);
            filenames  = strcat(dir_from,run_images);
            batch.spm.temporal.st.scans{i_run} = cellstr(filenames);
        end
        batches{end+1} = batch;
    end
    if ~isempty(batches)
        spm_jobman('run',batches)
    end
end
