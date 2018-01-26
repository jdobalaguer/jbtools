
function scan = scan_glm_secondlevelLOO(scan)
    %% scan = SCAN_GLM_SECONDLEVELLOO(scan)
    % second level contrast and statistics
    % with leave-one-out (LOO)
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.second, return; end
    
    % build folder
    scan_tool_print(scan,false,'\nBuild folder : ');
    scan = scan_tool_progress(scan,scan.running.subject.number * (scan.running.subject.number - 1));
    for j_subject = 1:scan.running.subject.number
        for i_subject = 1:scan.running.subject.number
            if (i_subject == j_subject), continue; end
            switch scan.job.secondLevel
                case 'beta'
                    for i_contrast = 1:length(scan.running.contrast{i_subject})
                        f_beta = find(scan.running.contrast{i_subject}(i_contrast).vector);
                        n_beta = length(f_beta);
                        file_first = cell(1,n_beta);
                        for i_beta = 1:n_beta
                            file_first{i_beta} = fullfile(scan.running.directory.original.first{i_subject},sprintf('%s_%04i.nii',scan.job.secondLevel,f_beta(i_beta)));
                        end
                        file_first  = char(file_first); %#ok<NASGU>
                        file_second = fullfile(scan.running.directory.original.second,'LOO',sprintf('subject_%03i',j_subject),sprintf('%s_%03i',scan.running.contrast{i_subject}(i_contrast).name,scan.running.contrast{i_subject}(i_contrast).order),sprintf('%s_subject_%03i.nii',scan.job.secondLevel,i_subject));
                        file_func   = strcat('(i1',sprintf(' + i%d',2:n_beta),sprintf(')./%d',n_beta)); %#ok<NASGU>
                        file_mkdir(fileparts(file_second));
                        evalc('spm_imcalc(file_first,file_second,file_func);');
                    end
                case {'con','spmT'}
                    for i_contrast = 1:length(scan.running.contrast{i_subject})
                        file_first  = fullfile(scan.running.directory.original.first{i_subject},sprintf('%s_%04i.nii',scan.job.secondLevel,i_contrast));
                        file_second = fullfile(scan.running.directory.original.second,'LOO',sprintf('subject_%03i',j_subject),sprintf('%s_%03i',scan.running.contrast{i_subject}(i_contrast).name,scan.running.contrast{i_subject}(i_contrast).order),sprintf('%s_subject_%03i.nii',scan.job.secondLevel,i_subject));
                        file_mkdir(fileparts(file_second));
                        scan_tool_copy(file_first,file_second);
                    end
                otherwise
                    scan_tool_error(scan,'scan.job.secondLevel is "%s" not valid. It must be one of {''beta'',''con'',''spmT''}');
            end
            scan = scan_tool_progress(scan,[]);
        end
    end
    scan = scan_tool_progress(scan,0);
    
    % second level analyses
    scan_tool_print(scan,false,'\nSPM analysis (second level) : ');
    scan = scan_tool_progress(scan,length(scan.running.contrast{1}) * (scan.running.subject.number));
    scan.running.jobs.second = cell(scan.running.subject.number,1);
    for j_subject = 1:scan.running.subject.number
        clear spm;
        j_job = 0;
        for i_contrast = 1:length(scan.running.contrast{j_subject})
            directory_second = fullfile(scan.running.directory.original.second,'LOO',sprintf('subject_%03i',j_subject),sprintf('%s_%03i',scan.running.contrast{j_subject}(i_contrast).name,scan.running.contrast{j_subject}(i_contrast).order));
            % design
            j_job = j_job + 1;
            spm{j_job}.spm.stats.factorial_design.dir                      = {directory_second}; %#ok<*AGROW>
            spm{j_job}.spm.stats.factorial_design.des.t1.scans             = file_list(fullfile(directory_second,'*.nii'),'absolute');
            spm{j_job}.spm.stats.factorial_design.cov                      = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
            spm{j_job}.spm.stats.factorial_design.masking.tm.tm_none       = 1;    % threshold masking
            spm{j_job}.spm.stats.factorial_design.masking.im               = 1;    % implicit mask
            spm{j_job}.spm.stats.factorial_design.masking.em               = {''}; % explicit mask
            spm{j_job}.spm.stats.factorial_design.globalc.g_omit           = 1;    % dont know what it is
            spm{j_job}.spm.stats.factorial_design.globalm.gmsca.gmsca_no   = 1;    % grand mean scaling
            spm{j_job}.spm.stats.factorial_design.globalm.glonorm          = 1;    % global normalization
            % estimate
            j_job = j_job + 1;
            spm{j_job}.spm.stats.fmri_est.spmmat           = {fullfile(directory_second,'SPM.mat')};
            spm{j_job}.spm.stats.fmri_est.method.Classical = 1;
            % contrast
            j_job = j_job + 1;
            spm{j_job}.spm.stats.con.spmmat                    = {fullfile(directory_second,'SPM.mat')};
            spm{j_job}.spm.stats.con.consess{1}.tcon.name      = sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order);
            spm{j_job}.spm.stats.con.consess{1}.tcon.convec    = 1; % contrast vector, here just 1, (simple T)
            spm{j_job}.spm.stats.con.consess{1}.tcon.sessrep   = 'none';
            spm{j_job}.spm.stats.con.delete = 1;
            % SPM
            evalc('spm_jobman(''run'',spm(j_job-2:j_job))');
            % wait
            scan = scan_tool_progress(scan,[]);
        end
        
        % save
        scan.running.jobs.second{j_subject} = spm;
    
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
