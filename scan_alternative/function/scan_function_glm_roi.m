
function scan = scan_function_glm_roi(scan)
    %% scan = SCAN_FUNCTION_GLM_ROI(scan)
    % define "roi" functions
    % to list main functions, try
    %   >> help scan;

    %% function
    scan_tool_print(scan,false,'\nAdd function (roi) : ');
    scan.function.roi = @auxiliar_roi;
    
    %% nested
    function roi = auxiliar_roi(level,type,mask)
        
        % assert
        scan_tool_assert(scan,any(strcmp(level,{'first','second'})),                    'roi = roi(level,type,roi)');
        scan_tool_assert(scan,any(strcmp(type,{'beta','contrast','statistic','spm'})),  'roi = roi(level,type,roi)');
        scan_tool_assert(scan,ischar(mask),                                             'roi = roi(level,type,roi)');
        
        % mask
        mask = scan_nifti_load(fullfile(scan.directory.mask,mask));
        
        % switch
        switch [level,':',type]
            
            % first level beta
            case 'first:beta'
                roi = struct();
                for i_subject = 1:scan.running.subject.number
                    for i_session = 1:scan.running.subject.session(i_subject)
                        u_column = unique(scan.running.design(i_subject).column.name);
                        if length(matlab.lang.makeValidName(u_column)) < length(u_column)
                            scan_tool_warning('two or more contrasts share the same name');
                        end
                        for i_column = 1:length(u_column)
                            ii_column = strcmp(scan.running.design(i_subject).column.name,u_column{i_column});
                            if any(scan.running.design(i_subject).column.covariate(ii_column)), continue; end
                            u_order  = unique(scan.running.design(i_subject).column.order(ii_column));
                            for i_order = 1:length(u_order)
                                file = fullfile(scan.running.directory.copy.first.beta,u_column{i_column},sprintf('subject_%03i session_%03i order_%03i.nii',scan.running.subject.unique(i_subject),i_session,u_order(i_order)));
                                vol  = scan_nifti_load(file,mask);
                                roi.(matlab.lang.makeValidName(u_column{i_column})){i_subject}(:,i_order,i_session) = vol;
                            end
                        end
                    end
                end
                
            % first level contrast
            case 'first:contrast'
                roi = struct();
                for i_subject = 1:scan.running.subject.number
                    u_contrast = {scan.running.contrast{i_subject}.name};
                    if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                        scan_tool_warning('two or more contrasts share the same name');
                    end
                    for i_contrast = 1:length(u_contrast)
                        file = fullfile(scan.running.directory.copy.first.contrast,u_contrast{i_contrast},sprintf('subject_%03i.nii',scan.running.subject.unique(i_subject)));
                        vol  = scan_nifti_load(file,mask);
                        roi.(matlab.lang.makeValidName(u_contrast{i_contrast})){i_subject}(:,1,1) = vol;
                    end
                end
                
            % first level statistic
            case 'first:statistic'
                roi = struct();
                for i_subject = 1:scan.running.subject.number
                    u_contrast = {scan.running.contrast{i_subject}.name};
                    if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                        scan_tool_warning('two or more contrasts share the same name');
                    end
                    for i_contrast = 1:length(u_contrast)
                        file = fullfile(scan.running.directory.copy.first.statistic,u_contrast{i_contrast},sprintf('subject_%03i.nii',scan.running.subject.unique(i_subject)));
                        vol  = scan_nifti_load(file,mask);
                        roi.(matlab.lang.makeValidName(u_contrast{i_contrast})){i_subject}(:,1,1) = vol;
                    end
                end
                
            % second level beta
            case 'second:beta'
                roi = struct();
                u_contrast = {scan.running.contrast{1}.name};
                if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                    scan_tool_warning('two or more contrasts share the same name');
                end
                for i_contrast = 1:length(u_contrast)
                    file = fullfile(scan.running.directory.copy.second.beta,sprintf('%s.nii',u_contrast{i_contrast}));
                    vol  = scan_nifti_load(file,mask);
                    roi.(matlab.lang.makeValidName(u_contrast{i_contrast}))(:,1,1) = vol;
                end
                
            % second level contrast
            case 'second:contrast'
                roi = struct();
                u_contrast = {scan.running.contrast{1}.name};
                if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                    scan_tool_warning('two or more contrasts share the same name');
                end
                for i_contrast = 1:length(u_contrast)
                    file = fullfile(scan.running.directory.copy.second.statistic,sprintf('%s.nii',u_contrast{i_contrast}));
                    vol  = scan_nifti_load(file,mask);
                    roi.(matlab.lang.makeValidName(u_contrast{i_contrast}))(:,1,1) = vol;
                end

            % second level statistic
            case 'second:statistic'
                roi = struct();
                u_contrast = {scan.running.contrast{1}.name};
                if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                    scan_tool_warning('two or more contrasts share the same name');
                end
                for i_contrast = 1:length(u_contrast)
                    file = fullfile(scan.running.directory.copy.second.contrast,sprintf('%s.nii',u_contrast{i_contrast}));
                    vol  = scan_nifti_load(file,mask);
                    roi.(matlab.lang.makeValidName(u_contrast{i_contrast}))(:,1,1) = vol;
                end
        end
    end
end
