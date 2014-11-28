
function [scan,job] = scan_preprocess_coregistration(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_COREGISTRATION(scan,job)
    % coregistration of raw data (structural to mean EPI)
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<*FPARK,*AGROW>

    %% FUNCTION
    
    % assert
    assertWarning(all(job.run==1),'scan_preprocess_coregistration: warning. job.run set to 1');
    job.run(:) = 1;
    
    % coregistration
    batches = {};
    for i_subject = scan.subject.u
        fprintf('Coregistration : subject %02i \n',i_subject);
        dir_mean = strcat(sprintf(job.mean.path,i_subject),filesep);
        file_mean = dir([dir_mean,job.mean.file]);
        file_mean = strcat(dir_mean,strvcat(file_mean.name));
        dir_from = strcat(sprintf(job.from.path,i_subject),filesep);
        file_from = dir([dir_from,job.from.file]);
        assert(length(file_from)==1,'scan_preprocess_coregistration: error. multiple structural files');
        copyfile([dir_from,file_from.name],[dir_from,'c',file_from.name]);
        batch = struct();
        batch.spm.spatial.coreg.estimate.ref    = {[file_mean,',1']};
        batch.spm.spatial.coreg.estimate.source = {[dir_from,'c',file_from.name,',1']};
        batch.spm.spatial.coreg.estimate.other  =  {''};
        batch.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
        batch.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
        batch.spm.spatial.coreg.estimate.eoptions.tol = [0.0200 0.0200 0.0200 0.0010 0.0010 0.0010 0.0100 0.0100 0.0100 0.0010 0.0010 0.0010];
        batch.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
        batches{end+1} = batch;
    end
    if ~isempty(batches)
        spm_jobman('run',batches)
    end
end
