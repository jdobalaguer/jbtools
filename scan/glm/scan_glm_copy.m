
function scan = scan_glm_copy(scan,level,type,force)
    %% scan = SCAN_GLM_COPY(scan,level,type)
    % copy files to [scan.running.directory.copy]
    % to list main functions, try
    %   >> help scan;

    %% function
    func_default('force',1);
    
    switch [level,':',type]
        % first level beta
        case 'first:beta'
            if ~force && ~any(ismember('beta_1',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.estimation, return; end
            scan_tool_print(scan,false,'\nCopy beta (first level) : ');
            scan = scan_tool_progress(scan,scan.running.subject.number);
            for i_subject = 1:scan.running.subject.number
                for i_column = 1:length(scan.running.design(i_subject).column.name)
                    if scan.running.design(i_subject).column.covariate(i_column), continue; end
                    original  = fullfile(scan.running.directory.original.first{i_subject},sprintf('beta_%04i.nii',i_column));
                    copy      = fullfile(scan.running.directory.copy.first.beta,strcat(scan.running.design(i_subject).column.name{i_column},scan.running.design(i_subject).column.version{i_column}),sprintf('subject_%03i session_%03i order_%03i.nii',scan.running.subject.unique(i_subject),scan.running.design(i_subject).column.session(i_column),scan.running.design(i_subject).column.order(i_column)));
                    file_mkdir(fileparts(copy));
                    scan_tool_copy(original,copy);
                end
                scan = scan_tool_progress(scan,[]);
            end
            scan = scan_tool_progress(scan,0);
            
        % first level contrast
        case 'first:contrast'
            if ~force && ~any(ismember('cont_1',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.first, return; end
            if ~force && ~strcmp(scan.job.type,'glm'), return; end
            scan_tool_print(scan,false,'\nCopy contrast (first level) : ');
            scan = scan_tool_progress(scan,scan.running.subject.number);
            for i_subject = 1:scan.running.subject.number
                for i_contrast = 1:length(scan.running.contrast{i_subject})
                    original  = fullfile(scan.running.directory.original.first{i_subject},sprintf('con_%04i.nii',i_contrast));
                    copy      = fullfile(scan.running.directory.copy.first.contrast,sprintf('%s_%03i',scan.running.contrast{i_subject}(i_contrast).name,scan.running.contrast{i_subject}(i_contrast).order),sprintf('subject_%03i.nii',scan.running.subject.unique(i_subject)));
                    file_mkdir(fileparts(copy));
                    scan_tool_copy(original,copy);
                end
                scan = scan_tool_progress(scan,[]);
            end
            scan = scan_tool_progress(scan,0);
            
        % first level statistic
        case 'first:statistic'
            if ~force && ~any(ismember('spmt_1',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.first, return; end
            if ~force && ~strcmp(scan.job.type,'glm'), return; end
            scan_tool_print(scan,false,'\nCopy statistic (first level) : ');
            scan = scan_tool_progress(scan,scan.running.subject.number);
            for i_subject = 1:scan.running.subject.number
                for i_contrast = 1:length(scan.running.contrast{i_subject})
                    original  = fullfile(scan.running.directory.original.first{i_subject},sprintf('spmT_%04i.nii',i_contrast));
                    copy      = fullfile(scan.running.directory.copy.first.statistic,sprintf('%s_%03i',scan.running.contrast{i_subject}(i_contrast).name,scan.running.contrast{i_subject}(i_contrast).order),sprintf('subject_%03i.nii',scan.running.subject.unique(i_subject)));
                    file_mkdir(fileparts(copy));
                    scan_tool_copy(original,copy);
                end
                scan = scan_tool_progress(scan,[]);
            end
            scan = scan_tool_progress(scan,0);
            
        % first level SPM mat-file
        case 'first:mask'
            if ~force && ~any(ismember('mask',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.estimation, return; end
            scan_tool_print(scan,false,'\nCopy mask (first level) : ');
            scan = scan_tool_progress(scan,scan.running.subject.number + 1);
            for i_subject = 1:scan.running.subject.number
                original  = fullfile(scan.running.directory.original.first{i_subject},'mask.nii');
                copy      = fullfile(scan.running.directory.mask.individual{i_subject},'wholebrain.nii');
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan = scan_tool_progress(scan,[]);
            end
            file_mkdir(scan.running.directory.mask.common);
            evalc('spm_imcalc(fullfile(scan.running.directory.mask.individual,''wholebrain.nii''),fullfile(scan.running.directory.mask.common,''wholebrain.nii''),strcat(''1'',sprintf('' & i%d'',1:scan.running.subject.number)));');
            scan = scan_tool_progress(scan,0);
        
        % first level SPM mat-file
        case 'first:spm'
            if ~force && ~any(ismember('spm_1',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.design, return; end
            scan_tool_print(scan,false,'\nCopy SPM mat-file (first level) : ');
            scan = scan_tool_progress(scan,scan.running.subject.number);
            for i_subject = 1:scan.running.subject.number
                original  = fullfile(scan.running.directory.original.first{i_subject},'SPM.mat');
                copy      = fullfile(scan.running.directory.copy.first.spm,sprintf('subject_%03i',scan.running.subject.unique(i_subject)),'SPM.mat');
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan = scan_tool_progress(scan,[]);
            end
            scan = scan_tool_progress(scan,0);
        
        % first level mean squared (MS) residuals
        case 'first:residualMS'
            if ~force && ~any(ismember('spm_1',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.design, return; end
            scan_tool_print(scan,false,'\nCopy residual maps (first level) : ');
            scan = scan_tool_progress(scan,scan.running.subject.number);
            for i_subject = 1:scan.running.subject.number
                original  = fullfile(scan.running.directory.original.first{i_subject},'ResMS.nii');
                copy      = fullfile(scan.running.directory.copy.first.residual,sprintf('subject_%03i_MS.nii',scan.running.subject.unique(i_subject)));
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan = scan_tool_progress(scan,[]);
            end
            scan = scan_tool_progress(scan,0);
            
        % first level all residuals
        case 'first:residual'
            if ~force && ~any(ismember('spm_1',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.design, return; end
            scan_tool_print(scan,false,'\nCopy residual maps (first level) : ');
            scan = scan_tool_progress(scan,scan.running.subject.number);
            for i_subject = 1:scan.running.subject.number
                spm = fullfile(scan.running.directory.original.first{i_subject},'SPM.mat');
                spm_write_residuals(spm,0);
                % copy mean square
                original  = fullfile(scan.running.directory.original.first{i_subject},'ResMS.nii');
                copy      = fullfile(scan.running.directory.copy.first.residual,sprintf('subject_%03i_MS.nii',scan.running.subject.unique(i_subject)));
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                % copy all other files
                original  = file_list(fullfile(scan.running.directory.original.first{i_subject},'Res_*.nii'),'absolute');
                copy      = fullfile(scan.running.directory.copy.first.residual,strrep(file_2local(original),'Res_',sprintf('subject_%03i_',scan.running.subject.unique(i_subject))));
                scan_tool_copy(original,copy);
                cellfun(@file_delete,original,'UniformOutput',false);
                % progress
                scan = scan_tool_progress(scan,[]);
            end
            scan = scan_tool_progress(scan,0);
        
        % second level beta
        case 'second:beta'
            if ~force && ~any(ismember('beta_2',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.second, return; end
            if ~force && ~strcmp(scan.job.type,'glm'), return; end
            scan_tool_print(scan,false,'\nCopy beta file (second level) : ');
            scan = scan_tool_progress(scan,length(scan.running.contrast{1}));
            for i_contrast = 1:length(scan.running.contrast{1})
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'beta_0001.nii');
                copy     = fullfile(scan.running.directory.copy.second.beta,sprintf('%s_%03i.nii',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order));
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan = scan_tool_progress(scan,[]);
            end
            scan = scan_tool_progress(scan,0);
            
        % second level contrast
        case 'second:contrast'
            if ~force && ~any(ismember('cont_2',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.second, return; end
            if ~force && ~strcmp(scan.job.type,'glm'), return; end
            scan_tool_print(scan,false,'\nCopy contrast file (second level) : ');
            scan = scan_tool_progress(scan,length(scan.running.contrast{1}));
            for i_contrast = 1:length(scan.running.contrast{1})
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'con_0001.nii');
                copy     = fullfile(scan.running.directory.copy.second.contrast,sprintf('%s_%03i.nii',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order));
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan = scan_tool_progress(scan,[]);
            end
            scan = scan_tool_progress(scan,0);
            
        % second level statistic
        case 'second:statistic'
            if ~force && ~any(ismember('spmt_2',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.second, return; end
            if ~force && ~strcmp(scan.job.type,'glm'), return; end
            scan_tool_print(scan,false,'\nCopy statistic file (second level) : ');
            scan = scan_tool_progress(scan,length(scan.running.contrast{1}));
            for i_contrast = 1:length(scan.running.contrast{1})
                % uncorrected
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'spmT_0001.nii');
                copy     = fullfile(scan.running.directory.copy.second.statistic,sprintf('%s_%03i.nii',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order));
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan = scan_tool_progress(scan,[]);
            end
            scan = scan_tool_progress(scan,0);
            
        % second level contrast
        case 'second:contrastLOO'
            if ~force && ~any(ismember('cont_2',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.second, return; end
            if ~force && ~strcmp(scan.job.type,'glm'), return; end
            scan_tool_print(scan,false,'\nCopy contrast file (second level LOO) : ');
            scan = scan_tool_progress(scan,length(scan.running.contrast{1}) * scan.running.subject.number);
            for j_subject = 1:scan.running.subject.number
            for i_contrast = 1:length(scan.running.contrast{j_subject})
                original = fullfile(scan.running.directory.original.second,'LOO',sprintf('subject_%03i',j_subject),sprintf('%s_%03i',scan.running.contrast{j_subject}(i_contrast).name,scan.running.contrast{j_subject}(i_contrast).order),'con_0001.nii');
                copy     = fullfile(scan.running.directory.copy.second.contrast,'LOO',sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),sprintf('subject_%04i.nii',scan.running.subject.unique(j_subject)));
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan = scan_tool_progress(scan,[]);
            end
            end
            scan = scan_tool_progress(scan,0);
            
        % second level contrast
        case 'second:statisticLOO'
            if ~force && ~any(ismember('cont_2',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.second, return; end
            if ~force && ~strcmp(scan.job.type,'glm'), return; end
            scan_tool_print(scan,false,'\nCopy contrast file (second level LOO) : ');
            scan = scan_tool_progress(scan,length(scan.running.contrast{1}) * scan.running.subject.number);
            for j_subject = 1:scan.running.subject.number
            for i_contrast = 1:length(scan.running.contrast{j_subject})
                original = fullfile(scan.running.directory.original.second,'LOO',sprintf('subject_%03i',j_subject),sprintf('%s_%03i',scan.running.contrast{j_subject}(i_contrast).name,scan.running.contrast{j_subject}(i_contrast).order),'spmT_0001.nii');
                copy     = fullfile(scan.running.directory.copy.second.statistic,'LOO',sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),sprintf('subject_%03i.nii',scan.running.subject.unique(j_subject)));
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan = scan_tool_progress(scan,[]);
            end
            end
            scan = scan_tool_progress(scan,0);
        
        % second level statistic
        case 'second:tfce'
            if ~scan.job.tfce, return; end
            if ~force && ~any(ismember('spmt_2',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.second, return; end
            if ~force && ~strcmp(scan.job.type,'glm'), return; end
            scan_tool_print(scan,false,'\nCopy statistic file (second level) : ');
            scan = scan_tool_progress(scan,length(scan.running.contrast{1}));
            for i_contrast = 1:length(scan.running.contrast{1})
                % log(P) uncorrected
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'TFCE_log_p_0001.nii');
                copy     = fullfile(scan.running.directory.copy.second.statistic,sprintf('%s_%03i(TFCE).nii',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order));
                file_mkdir(fileparts(copy));
                meta = spm_vol(original);
                meta.descrip = sprintf('SPM{tfceLP_[%.1f]} - contrast 1: %s_%03i',scan.running.subject.number-1,scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order);
                vol  = spm_read_vols(meta);
                scan_nifti_save(copy,vol,meta);
                % log(P) false discovery rate
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'TFCE_log_pFDR_0001.nii');
                copy     = fullfile(scan.running.directory.copy.second.statistic,sprintf('%s_%03i(TFCEfdr).nii',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order));
                file_mkdir(fileparts(copy));
                meta = spm_vol(original);
                meta.descrip = sprintf('SPM{tfceLPfdr_[%.1f]} - contrast 1: %s_%03i',scan.running.subject.number-1,scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order);
                vol  = spm_read_vols(meta);
                scan_nifti_save(copy,vol,meta);
                % log(P) family-wise error
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'TFCE_log_pFWE_0001.nii');
                copy     = fullfile(scan.running.directory.copy.second.statistic,sprintf('%s_%03i(TFCEfwe).nii',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order));
                file_mkdir(fileparts(copy));
                meta = spm_vol(original);
                meta.descrip = sprintf('SPM{tfceLPfwe_[%.1f]} - contrast 1: %s_%03i',scan.running.subject.number-1,scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order);
                vol  = spm_read_vols(meta);
                scan_nifti_save(copy,vol,meta);
            end
            scan = scan_tool_progress(scan,0);
        
        % second level SPM mat-file
        case 'second:spm'
            if ~force && ~any(ismember('spm_2',scan.job.copyFolder)), return; end
            if ~force && ~scan.running.flag.second, return; end
            if ~force && ~strcmp(scan.job.type,'glm'), return; end
            scan_tool_print(scan,false,'\nCopy SPM mat-file (second level) : ');
            scan = scan_tool_progress(scan,length(scan.running.contrast{1}));
            for i_contrast = 1:length(scan.running.contrast{1})
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'SPM.mat');
                copy     = fullfile(scan.running.directory.copy.second.spm,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'SPM.mat');
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan = scan_tool_progress(scan,[]);
            end
            scan = scan_tool_progress(scan,0);
            
        % not valid
        otherwise
            scan_tool_error(scan,'level "%s" or type "%s" not valid',level,type);
    end
end
