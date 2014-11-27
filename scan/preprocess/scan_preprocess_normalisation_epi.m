
function [scan,job] = scan_preprocess_normalisation_epi(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_NORMALISATION_EPI(scan,job)
    % preprocessing normalisation (EPI to MNI space)
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<*FPARK,*AGROW>

    %% FUNCTION
    batches = {};
    for i_subject = scan.subject.u
        dir_sub  = strtrim(scan.dire.nii.subs(i_subject,:));
        dir_runs = dir([strtrim(scan.dire.nii.epi3(i_subject,:)),'run*']);
        dir_runs = strcat(strvcat(dir_runs.name),filesep);
        nb_runs  = size(dir_runs, 1);
        u_run    = 1:nb_runs;
        if ~job.run, u_run = 1; end
        fprintf('Writing normalized epis for:     %s\n',dir_sub);
        dir_norm  = strcat(dir_sub,job.norm.path,filesep);
        file_norm = dir([dir_norm,job.norm.file]);
        assert(length(file_norm)==1,'scan_preprocess_normalisation_epi: error. multiple files for normalisation parameters');
        file_norm = [dir_norm,filesep,file_norm.name];
        batch = struct();
        batch.spm.spatial.normalise.write.roptions.preserve = 0;
        batch.spm.spatial.normalise.write.roptions.bb       = [-78 -112 -50; 78 76 85];
        batch.spm.spatial.normalise.write.roptions.vox      = repmat(scan.pars.voxs,[1,3]);
        batch.spm.spatial.normalise.write.roptions.interp   = 1;
        batch.spm.spatial.normalise.write.roptions.wrap     = [0 0 0];
        batch.spm.spatial.normalise.write.roptions.prefix   = 'w';
        file_from = {};
        for i_run = u_run
            if job.run, dir_from = strcat(dir_sub,sprintf(job.from.path,i_run),filesep);
            else        dir_from = strcat(dir_sub,job.from.path,filesep);
            end
            run_images = dir([dir_from,job.from.file]);
            run_images = strvcat(run_images.name);
            file_from{i_run} = strcat(dir_from,run_images);
        end
        batch.spm.spatial.normalise.write.subj.resample = cellstr(strvcat(file_from));
        batch.spm.spatial.normalise.write.subj.matname = {file_norm};
        batches{end+1} = batch;
    end
    if ~isempty(batches)
        spm_jobman('run',batches)
    end
end
