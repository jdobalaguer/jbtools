
function scan = scan_glm_firstlevel(scan)
    %% scan = SCAN_GLM_FIRSTLEVEL(scan)
    % first level contrast and statistics
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.first, return; end
    
    % print
    scan_tool_print(scan,false,'\nSPM analysis (first level) : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    parfor (i_subject = 1:scan.running.subject.number, mme_size())
        spm(i_subject) = auxiliar(scan,i_subject);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.first = spm;
    
    % done
    scan = scan_tool_done(scan);
end

%% auxiliar
function spm = auxiliar(scan,i_subject)
    % job
    spm{1}.spm.stats.con.spmmat = fullfile(scan.running.directory.original.first(i_subject),'SPM.mat');
    for i_contrast = 1:length(scan.running.contrast{i_subject})
        spm{1}.spm.stats.con.consess{i_contrast}.tcon.name      = sprintf('%s_%03i',scan.running.contrast{i_subject}(i_contrast).name,scan.running.contrast{i_subject}(i_contrast).order);
        spm{1}.spm.stats.con.consess{i_contrast}.tcon.convec    = scan.running.contrast{i_subject}(i_contrast).vector;
        spm{1}.spm.stats.con.consess{i_contrast}.tcon.sessrep   = 'none';
    end
    spm{1}.spm.stats.con.delete = 1;

    % SPM
    evalc('spm_jobman(''run'',spm)');

    % wait
    scan_tool_progress(scan,[]);
end
