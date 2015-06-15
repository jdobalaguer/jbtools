
function scan = scan_function_glm_get_roi(scan)
    %% scan = SCAN_FUNCTION_GLM_GET_ROI(scan)
    % define function @get.roi
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function,   return; end
    if ~scan.running.flag.estimation, return; end
    scan.function.get.roi = @auxiliar_roi;
    
    %% nested
    function varargout = auxiliar_roi(varargin)
        if nargin~=3 || strcmp(varargin{1},'help')
            varargout = {};
            scan_tool_help('roi = @get.roi(level,type,mask)','This function loads the [type] values estimated by the [level] analysis within a region of interest for every column/contrast. [level] is a string {''first'',''second''}. [type] is a string {''beta'',''cont'',''spmt''}. [mask] is a the path to a nii/img file relative to [scan.directory.mask]');
            return;
        end
        
        % default
        [level,type,mask] = deal(varargin{1:3});
        
        % assert
        if ~any(strcmp(level,{'first','second'})),              auxiliar_roi('help'); return; end
        if ~any(strcmp(type,{'beta','contrast','statistic'})),  auxiliar_roi('help'); return; end
        if ~ischar(mask),                                       auxiliar_roi('help'); return; end
        
        % mask
        mask = scan_nifti_load(fullfile(scan.directory.mask,mask));
        
        % switch
        roi = struct();
        switch [level,':',type]
            
            % first level beta
            case 'first:beta'
                roi = struct();
                for i_subject = 1:scan.running.subject.number
                    for i_session = 1:scan.running.subject.session(i_subject)
                        u_column = unique(scan.running.design(i_subject).column.name);
                        if length(matlab.lang.makeValidName(u_column)) < length(u_column)
                            scan_tool_warning('two or more columns share the same name');
                        end
                        ii_session = (scan.running.design(i_subject).column.session == i_session);
                        for i_column = 1:length(u_column)
                            ii_column = strcmp(scan.running.design(i_subject).column.name,u_column{i_column});
                            if any(scan.running.design(i_subject).column.covariate(ii_column & ii_session)), continue; end
                            u_order  = unique(scan.running.design(i_subject).column.order(ii_column & ii_session));
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
                    u_contrast = unique({scan.running.contrast{i_subject}.name});
                    if length(unique(matlab.lang.makeValidName(u_contrast))) < length(u_contrast)
                        scan_tool_warning('two or more contrasts share the same valid name');
                    end
                    for i_contrast = 1:length(u_contrast)
                        ii_contrast = strcmp(u_contrast{i_contrast},{scan.running.contrast{i_subject}.name});
                        u_order = [scan.running.contrast{i_subject}(ii_contrast).order];
                        for i_order = 1:length(u_order)
                            file = fullfile(scan.running.directory.copy.first.contrast,sprintf('%s_%03i',u_contrast{i_contrast},u_order(i_order)),sprintf('subject_%03i.nii',scan.running.subject.unique(i_subject)));
                            vol  = scan_nifti_load(file,mask);
                            roi.(matlab.lang.makeValidName(u_contrast{i_contrast})){i_subject}(:,i_order,1) = vol;
                        end
                    end
                end
                
            % first level statistic
            case 'first:statistic'
                roi = struct();
                for i_subject = 1:scan.running.subject.number
                    u_contrast = unique({scan.running.contrast{i_subject}.name});
                    if length(unique(matlab.lang.makeValidName(u_contrast))) < length(u_contrast)
                        scan_tool_warning('two or more contrasts share the same valid name');
                    end
                    for i_contrast = 1:length(u_contrast)
                        ii_contrast = strcmp(u_contrast{i_contrast},{scan.running.contrast{i_subject}.name});
                        u_order = [scan.running.contrast{i_subject}(ii_contrast).order];
                        for i_order = 1:length(u_order)
                            file = fullfile(scan.running.directory.copy.first.statistic,sprintf('%s_%03i',u_contrast{i_contrast},u_order(i_order)),sprintf('subject_%03i.nii',scan.running.subject.unique(i_subject)));
                            vol  = scan_nifti_load(file,mask);
                            roi.(matlab.lang.makeValidName(u_contrast{i_contrast})){i_subject}(:,i_order,1) = vol;
                        end
                    end
                end
                
            % second level beta
            case 'second:beta'
                roi = struct();
                u_contrast = unique({scan.running.contrast{1}.name});
                if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                    scan_tool_warning('two or more contrasts share the same name');
                end
                for i_contrast = 1:length(u_contrast)
                    ii_contrast = strcmp(u_contrast{i_contrast},{scan.running.contrast{1}.name});
                    u_order = [scan.running.contrast{1}(ii_contrast).order];
                    for i_order = 1:length(u_order)
                        file = fullfile(scan.running.directory.copy.second.beta,sprintf('%s_%03i.nii',u_contrast{i_contrast},u_order(i_order)));
                        vol  = scan_nifti_load(file,mask);
                        roi.(matlab.lang.makeValidName(u_contrast{i_contrast}))(:,i_order,1) = vol;
                    end
                end
                
            % second level contrast
            case 'second:contrast'
                roi = struct();
                u_contrast = unique({scan.running.contrast{1}.name});
                if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                    scan_tool_warning('two or more contrasts share the same name');
                end
                for i_contrast = 1:length(u_contrast)
                    ii_contrast = strcmp(u_contrast{i_contrast},{scan.running.contrast{1}.name});
                    u_order = [scan.running.contrast{1}(ii_contrast).order];
                    for i_order = 1:length(u_order)
                        file = fullfile(scan.running.directory.copy.second.contrast,sprintf('%s_%03i.nii',u_contrast{i_contrast},u_order(i_order)));
                        vol  = scan_nifti_load(file,mask);
                        roi.(matlab.lang.makeValidName(u_contrast{i_contrast}))(:,i_order,1) = vol;
                    end
                end

            % second level statistic
            case 'second:statistic'
                roi = struct();
                u_contrast = unique({scan.running.contrast{1}.name});
                if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                    scan_tool_warning('two or more contrasts share the same name');
                end
                for i_contrast = 1:length(u_contrast)
                    ii_contrast = strcmp(u_contrast{i_contrast},{scan.running.contrast{1}.name});
                    u_order = [scan.running.contrast{1}(ii_contrast).order];
                    for i_order = 1:length(u_order)
                        file = fullfile(scan.running.directory.copy.second.statistic,sprintf('%s_%03i.nii',u_contrast{i_contrast},u_order(i_order)));
                        vol  = scan_nifti_load(file,mask);
                        roi.(matlab.lang.makeValidName(u_contrast{i_contrast}))(:,i_order,1) = vol;
                    end
                end
        end
        
        % return
        varargout = {roi};
    end
end
