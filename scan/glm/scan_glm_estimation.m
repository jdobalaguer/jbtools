
function scan = scan_glm_estimation(scan)
    %% scan = SCAN_GLM_ESTIMATION(scan)
    % estimate beta values
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.estimation, return; end
    
    % print
    scan_tool_print(scan,false,'\nSPM Estimation : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    parfor (i_subject = 1:scan.running.subject.number, mme_size())
        spm(i_subject) = auxiliar(scan,i_subject);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.estimation = spm;
    
    % done
    scan = scan_tool_done(scan);
end

%% auxiliar
function spm = auxiliar(scan,i_subject)
    % job
    spm{1}.spm.stats.fmri_est.spmmat = {fullfile(scan.running.directory.original.first{i_subject},'SPM.mat')}; %#ok<*AGROW>
    spm{1}.spm.stats.fmri_est.method.Classical = 1;

    % SPM
    evalc('spm_jobman(''run'',spm)');

    % wait
    scan_tool_progress(scan,[]);
end
