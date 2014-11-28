
function [scan,job] = scan_preprocess_normalisation_mni(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_NORMALISATION_MNI(scan,job)
    % preprocessing inverse of normalisation (MNI to EPI space)
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<*FPARK,*AGROW,*NASGU>

    %% FUNCTION
    
    % assert
    assert(isfield(job,'move'),             'scan_preprocess_normalisation_mni: warning. no job.move field');
    assert(isfield(job.move,'path'),        'scan_preprocess_normalisation_mni: warning. no job.move.path field');
    assertWarning(isempty(job.move.file),   'scan_preprocess_normalisation_mni: warning. job.move.file will be ignored');
    
    batches = {};
    for i_subject = scan.subject.u
        nb_runs     = job.run(i_subject);
        u_run       = 1:nb_runs;
        
        for i_run = u_run
            fprintf('Normalisation (MNI) : subject %02i : run %d \n',i_subject,i_run);
            
            % file norm
            dir_norm  = strcat(sprintf(job.norm.path,i_subject),filesep);
            file_norm = dir([dir_norm,job.norm.file]);
            assert(length(file_norm)==1,'scan_preprocess_normalisation_mni: error. multiple files for normalisation parameters');
            file_norm = [dir_norm,filesep,file_norm.name];

            % file space
            dir_orig  = strcat(sprintf(job.orig.path,i_subject),filesep);
            file_orig = dir([dir_orig,job.orig.file]);
            assert(length(file_orig)==1,'scan_preprocess_normalisation_mni: error. multiple original space files');
            file_orig = [dir_orig,filesep,file_orig.name];

            % file move
            if nb_runs==1,  dir_from = strcat(sprintf(job.from.path,i_subject),filesep);
                            dir_move  = strcat(sprintf(job.move.path,i_subject),filesep);
            else            dir_from = strcat(sprintf(job.from.path,i_subject,i_run),filesep);
                            dir_move  = strcat(sprintf(job.move.path,i_subject,i_run),filesep);
            end
            mkdirp(dir_move);
            run_images = dir([dir_from,job.from.file]);
            run_images = strvcat(run_images.name);
            file_from  = strcat(dir_from,run_images);
            
            % estimate inversed normalization
            batch = struct();
            batch.spm.util.defs.comp{1}.inv.comp{1}.sn2def.matname    = {file_norm};
            batch.spm.util.defs.comp{1}.inv.comp{1}.sn2def.bb         = [-78 -112 -50; 78 76 85];
            batch.spm.util.defs.comp{1}.inv.comp{1}.sn2def.vox        = repmat(scan.pars.voxs,[1,3]);
            batch.spm.util.defs.comp{1}.inv.space                     = {file_orig};
            batch.spm.util.defs.ofname                                = '';
            batch.spm.util.defs.fnames                                = cellstr(strvcat(file_from));
            batch.spm.util.defs.savedir.saveusr                       = {dir_move};
            batch.spm.util.defs.interp                                = 1;
            batches{end+1} = batch;
        end

    end
    if ~isempty(batches)
        spm_jobman('run',batches)
    end
    
    job = rmfield(job,'move');
end
