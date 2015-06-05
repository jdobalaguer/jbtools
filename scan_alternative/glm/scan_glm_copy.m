
function scan = scan_glm_copy(scan,level,type)
    %% scan = SCAN_GLM_COPY(scan)
    % copy files to [scan.running.directory.copy]
    % to list main functions, try
    %   >> help scan;

    %% note
    % 1) i need to add [column.covariate] flag that specifies whether to copy (e.g. condition or ppi) or not (e.g. realignment or constant)

    %% function
    
    switch [level,':',type]
        % first level beta
        case 'first:beta'
            if ~any(ismember('beta_1',scan.job.copyFolder)), return; end
            scan_tool_print(scan,false,'\nCopy beta (first level) : ');
            scan_tool_progress(scan,scan.running.subject.number);
            for i_subject = 1:scan.running.subject.number
                for i_column = 1:length(scan.running.design(i_subject).column.name)
                    if scan.running.design(i_subject).column.covariate(i_column), continue; end
                    original  = fullfile(scan.running.directory.original.first{i_subject},sprintf('beta_%04i.img',i_column));
                    copy      = fullfile(scan.running.directory.copy.first.beta,scan.running.design(i_subject).column.name{i_column},sprintf('subject_%03i session_%03i order_%03i.nii',scan.running.subject.unique(i_subject),scan.running.design(i_subject).column.session(i_column),scan.running.design(i_subject).column.order(i_column)));
                    file_mkdir(fileparts(copy));
                    scan_tool_copy(original,copy);
                end
                scan_tool_progress(scan,[]);
            end
            scan_tool_progress(scan,0);
            
        % first level contrast
        case 'first:contrast'
            if ~any(ismember('cont_1',scan.job.copyFolder)), return; end
            scan_tool_print(scan,false,'\nCopy contrast (first level) : ');
            scan_tool_progress(scan,scan.running.subject.number);
            for i_subject = 1:scan.running.subject.number
                for i_contrast = 1:length(scan.running.contrast{i_subject})
                    original  = fullfile(scan.running.directory.original.first{i_subject},sprintf('con_%04i.img',i_contrast));
                    copy      = fullfile(scan.running.directory.copy.first.contrast,sprintf('%s_%03i',scan.running.contrast{i_subject}(i_contrast).name,scan.running.contrast{i_subject}(i_contrast).order),sprintf('subject_%03i.nii',scan.running.subject.unique(i_subject)));
                    file_mkdir(fileparts(copy));
                    scan_tool_copy(original,copy);
                end
                scan_tool_progress(scan,[]);
            end
            scan_tool_progress(scan,0);
            
        % first level statistic
        case 'first:statistic'
            if ~any(ismember('spmt_1',scan.job.copyFolder)), return; end
            scan_tool_print(scan,false,'\nCopy statistic (first level) : ');
            scan_tool_progress(scan,scan.running.subject.number);
            for i_subject = 1:scan.running.subject.number
                for i_contrast = 1:length(scan.running.contrast{i_subject})
                    original  = fullfile(scan.running.directory.original.first{i_subject},sprintf('spmT_%04i.img',i_contrast));
                    copy      = fullfile(scan.running.directory.copy.first.statistic,sprintf('%s_%03i',scan.running.contrast{i_subject}(i_contrast).name,scan.running.contrast{i_subject}(i_contrast).order),sprintf('subject_%03i.nii',scan.running.subject.unique(i_subject)));
                    file_mkdir(fileparts(copy));
                    scan_tool_copy(original,copy);
                end
                scan_tool_progress(scan,[]);
            end
            scan_tool_progress(scan,0);
            
        % first level SPM mat-file
        case 'first:spm'
            if ~any(ismember('spm_1',scan.job.copyFolder)), return; end
            scan_tool_print(scan,false,'\nCopy SPM mat-file (first level) : ');
            scan_tool_progress(scan,scan.running.subject.number);
            for i_subject = 1:scan.running.subject.number
                original  = fullfile(scan.running.directory.original.first{i_subject},'SPM.mat');
                copy      = fullfile(scan.running.directory.copy.first.spm,sprintf('subject_%03i',scan.running.subject.unique(i_subject)),'SPM.mat');
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan_tool_progress(scan,[]);
            end
            scan_tool_progress(scan,0);
        
        % second level beta
        case 'second:beta'
            if ~any(ismember('beta_2',scan.job.copyFolder)), return; end
            scan_tool_print(scan,false,'\nCopy beta file (second level) : ');
            scan_tool_progress(scan,length(scan.running.contrast{1}));
            for i_contrast = 1:length(scan.running.contrast{1})
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'beta_0001.img');
                copy     = fullfile(scan.running.directory.copy.second.beta,sprintf('%s_%03i.nii',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order));
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan_tool_progress(scan,[]);
            end
            scan_tool_progress(scan,0);
            
        % second level contrast
        case 'second:contrast'
            if ~any(ismember('cont_2',scan.job.copyFolder)), return; end
            scan_tool_print(scan,false,'\nCopy contrast file (second level) : ');
            scan_tool_progress(scan,length(scan.running.contrast{1}));
            for i_contrast = 1:length(scan.running.contrast{1})
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'con_0001.img');
                copy     = fullfile(scan.running.directory.copy.second.contrast,sprintf('%s_%03i.nii',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order));
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan_tool_progress(scan,[]);
            end
            scan_tool_progress(scan,0);
            
        % second level statistic
        case 'second:statistic'
            if ~any(ismember('spmt_2',scan.job.copyFolder)), return; end
            scan_tool_print(scan,false,'\nCopy statistic file (second level) : ');
            scan_tool_progress(scan,length(scan.running.contrast{1}));
            for i_contrast = 1:length(scan.running.contrast{1})
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'spmT_0001.img');
                copy     = fullfile(scan.running.directory.copy.second.statistic,sprintf('%s_%03i.nii',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order));
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan_tool_progress(scan,[]);
            end
            scan_tool_progress(scan,0);
        
        % second level SPM mat-file
        case 'second:spm'
            if ~any(ismember('spm_2',scan.job.copyFolder)), return; end
            scan_tool_print(scan,false,'\nCopy SPM mat-file (second level) : ');
            scan_tool_progress(scan,length(scan.running.contrast{1}));
            for i_contrast = 1:length(scan.running.contrast{1})
                original = fullfile(scan.running.directory.original.second,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'SPM.mat');
                copy     = fullfile(scan.running.directory.copy.second.spm,sprintf('%s_%03i',scan.running.contrast{1}(i_contrast).name,scan.running.contrast{1}(i_contrast).order),'SPM.mat');
                file_mkdir(fileparts(copy));
                scan_tool_copy(original,copy);
                scan_tool_progress(scan,[]);
            end
            scan_tool_progress(scan,0);
            
        % not valid
        otherwise
            scan_tool_error(scan,'level "%s" or type "%s" not valid',level,type);
    end
end
