
function scan = scan_glm_firstlevel(scan)
    %% scan = SCAN_GLM_FIRSTLEVEL(scan)
    % first level contrast and statistics
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.first, return; end
    
    % print
    scan_tool_print(scan,false,'\nSPM analysis (first level) : ');
    scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % job
        spm{i_subject}.spm.stats.con.spmmat = fullfile(scan.running.directory.original.first(i_subject),'SPM.mat');
        for i_contrast = 1:length(scan.running.contrast{i_subject})
            spm{i_subject}.spm.stats.con.consess{i_contrast}.tcon.name      = sprintf('%s_%03i',scan.running.contrast{i_subject}(i_contrast).name,scan.running.contrast{i_subject}(i_contrast).order);
            spm{i_subject}.spm.stats.con.consess{i_contrast}.tcon.convec    = scan.running.contrast{i_subject}(i_contrast).vector;
            spm{i_subject}.spm.stats.con.consess{i_contrast}.tcon.sessrep   = 'none';
        end
        spm{i_subject}.spm.stats.con.delete = 1;

        % SPM
        evalc('spm_jobman(''run'',spm(i_subject))');
        
       % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.first = spm;
end
