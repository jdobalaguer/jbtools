
function scan = scan_function_glm_get_roi(scan)
    %% scan = SCAN_FUNCTION_GLM_GET_ROI(scan)
    % define function @get.roi
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function,   return; end
    if ~scan.running.flag.estimation, return; end
    scan.function.get.roi = @auxiliar_roi;
end

%% auxiliar
function varargout = auxiliar_roi(varargin)
    varargout = cell(1,nargout);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=4 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'roi = @get.roi(scan,level,type,mask)','This function loads the [type] values estimated by the [level] analysis within a region of interest for every column/contrast. [level] is a string {''first'',''second''}. [type] is a string {''beta'',''cont'',''spmt''}. [mask] is a the path to a nii/img file relative to [scan.directory.mask]');
        return;
    end

    % default
    [level,type,mask] = varargin{2:4};

    % assert
    if ~any(strcmp(level,{'first','second'})),              auxiliar_roi(tcan,'help'); return; end
    if ~any(strcmp(type,{'beta','contrast','statistic'})),  auxiliar_roi(tcan,'help'); return; end
    if ~ischar(mask),                                       auxiliar_roi(tcan,'help'); return; end

    % mask
    mask = scan_nifti_load(fullfile(tcan.directory.mask,mask));

    % switch
    roi = struct();
    switch [level,':',type]

        % first level beta
        case 'first:beta'
            roi = struct();
            for i_subject = 1:tcan.running.subject.number
                for i_session = 1:tcan.running.subject.session(i_subject)
                    u_column = unique(tcan.running.design(i_subject).column.name);
                    if length(matlab.lang.makeValidName(u_column)) < length(u_column)
                        scan_tool_warning('two or more columns share the same name');
                    end
                    ii_session = (tcan.running.design(i_subject).column.session == i_session);
                    for i_column = 1:length(u_column)
                        ii_column = strcmp(tcan.running.design(i_subject).column.name,u_column{i_column});
                        if any(tcan.running.design(i_subject).column.covariate(ii_column & ii_session)), continue; end
                        u_order  = unique(tcan.running.design(i_subject).column.order(ii_column & ii_session));
                        for i_order = 1:length(u_order)
                            file = fullfile(tcan.running.directory.copy.first.beta,u_column{i_column},sprintf('subject_%03i session_%03i order_%03i.nii',tcan.running.subject.unique(i_subject),i_session,u_order(i_order)));
                            vol  = scan_nifti_load(file,mask);
                            roi.(matlab.lang.makeValidName(u_column{i_column})){i_subject}(:,i_order,i_session) = vol;
                        end
                    end
                end
            end

        % first level contrast
        case 'first:contrast'
            roi = struct();
            for i_subject = 1:tcan.running.subject.number
                u_contrast = unique({tcan.running.contrast{i_subject}.name});
                if length(unique(matlab.lang.makeValidName(u_contrast))) < length(u_contrast)
                    scan_tool_warning('two or more contrasts share the same valid name');
                end
                for i_contrast = 1:length(u_contrast)
                    ii_contrast = strcmp(u_contrast{i_contrast},{tcan.running.contrast{i_subject}.name});
                    u_order = [tcan.running.contrast{i_subject}(ii_contrast).order];
                    for i_order = 1:length(u_order)
                        file = fullfile(tcan.running.directory.copy.first.contrast,sprintf('%s_%03i',u_contrast{i_contrast},u_order(i_order)),sprintf('subject_%03i.nii',tcan.running.subject.unique(i_subject)));
                        vol  = scan_nifti_load(file,mask);
                        roi.(matlab.lang.makeValidName(u_contrast{i_contrast})){i_subject}(:,i_order,1) = vol;
                    end
                end
            end

        % first level statistic
        case 'first:statistic'
            roi = struct();
            for i_subject = 1:tcan.running.subject.number
                u_contrast = unique({tcan.running.contrast{i_subject}.name});
                if length(unique(matlab.lang.makeValidName(u_contrast))) < length(u_contrast)
                    scan_tool_warning('two or more contrasts share the same valid name');
                end
                for i_contrast = 1:length(u_contrast)
                    ii_contrast = strcmp(u_contrast{i_contrast},{tcan.running.contrast{i_subject}.name});
                    u_order = [tcan.running.contrast{i_subject}(ii_contrast).order];
                    for i_order = 1:length(u_order)
                        file = fullfile(tcan.running.directory.copy.first.statistic,sprintf('%s_%03i',u_contrast{i_contrast},u_order(i_order)),sprintf('subject_%03i.nii',tcan.running.subject.unique(i_subject)));
                        vol  = scan_nifti_load(file,mask);
                        roi.(matlab.lang.makeValidName(u_contrast{i_contrast})){i_subject}(:,i_order,1) = vol;
                    end
                end
            end

        % second level beta
        case 'second:beta'
            roi = struct();
            u_contrast = unique({tcan.running.contrast{1}.name});
            if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                scan_tool_warning('two or more contrasts share the same name');
            end
            for i_contrast = 1:length(u_contrast)
                ii_contrast = strcmp(u_contrast{i_contrast},{tcan.running.contrast{1}.name});
                u_order = [tcan.running.contrast{1}(ii_contrast).order];
                for i_order = 1:length(u_order)
                    file = fullfile(tcan.running.directory.copy.second.beta,sprintf('%s_%03i.nii',u_contrast{i_contrast},u_order(i_order)));
                    vol  = scan_nifti_load(file,mask);
                    roi.(matlab.lang.makeValidName(u_contrast{i_contrast}))(:,i_order,1) = vol;
                end
            end

        % second level contrast
        case 'second:contrast'
            roi = struct();
            u_contrast = unique({tcan.running.contrast{1}.name});
            if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                scan_tool_warning('two or more contrasts share the same name');
            end
            for i_contrast = 1:length(u_contrast)
                ii_contrast = strcmp(u_contrast{i_contrast},{tcan.running.contrast{1}.name});
                u_order = [tcan.running.contrast{1}(ii_contrast).order];
                for i_order = 1:length(u_order)
                    file = fullfile(tcan.running.directory.copy.second.contrast,sprintf('%s_%03i.nii',u_contrast{i_contrast},u_order(i_order)));
                    vol  = scan_nifti_load(file,mask);
                    roi.(matlab.lang.makeValidName(u_contrast{i_contrast}))(:,i_order,1) = vol;
                end
            end

        % second level statistic
        case 'second:statistic'
            roi = struct();
            u_contrast = unique({tcan.running.contrast{1}.name});
            if length(matlab.lang.makeValidName(u_contrast)) < length(u_contrast)
                scan_tool_warning('two or more contrasts share the same name');
            end
            for i_contrast = 1:length(u_contrast)
                ii_contrast = strcmp(u_contrast{i_contrast},{tcan.running.contrast{1}.name});
                u_order = [tcan.running.contrast{1}(ii_contrast).order];
                for i_order = 1:length(u_order)
                    file = fullfile(tcan.running.directory.copy.second.statistic,sprintf('%s_%03i.nii',u_contrast{i_contrast},u_order(i_order)));
                    vol  = scan_nifti_load(file,mask);
                    roi.(matlab.lang.makeValidName(u_contrast{i_contrast}))(:,i_order,1) = vol;
                end
            end
    end

    % return
    varargout = {roi};
end
