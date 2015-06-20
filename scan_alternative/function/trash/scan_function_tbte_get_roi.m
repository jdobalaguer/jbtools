
function scan = scan_function_tbte_get_roi(scan)
    %% scan = SCAN_FUNCTION_TBTE_GET_ROI(scan)
    % define "roi" functions
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function,   return; end
    if ~scan.running.flag.estimation, return; end
    scan.function.roi = @auxiliar_roi;
end

%% auxiliar
function roi = auxiliar_roi(varargin)
    roi = struct();
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=2 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'roi = @roi(scan,mask)','This function loads the beta values estimated within a region of interest for every onset type. [mask] is a the path to a nii/img file relative to [scan.directory.mask]');
        return;
    end

    % default
    mask = varargin{2};

    % assert
    if ~ischar(mask), auxiliar_roi(tcan,'help'); return; end

    % mask
    mask = logical(scan_nifti_load(fullfile(tcan.directory.mask,mask)));


    % load beta
    roi = struct();
    for i_subject = 1:tcan.running.subject.number
        u_main = unique(tcan.running.design(i_subject).column.main);
        if length(matlab.lang.makeValidName(u_main)) < length(u_main)
            scan_tool_warning('two or more kinds of onset share the same name');
        end
        for i_main = 1:length(u_main)
            ii_main = strcmp(tcan.running.design(i_subject).column.main,u_main{i_main});
            f_main      = find(ii_main);
            t_session   = tcan.running.design(i_subject).column.session(ii_main);
            t_column    = get_count(t_session);
            t_covariate = tcan.running.design(i_subject).column.covariate(ii_main);
            [u_session,n_session] = numbers(t_session);
            [u_column, n_column]  = numbers(t_column);

            if any(t_covariate), continue; end
            roi.(matlab.lang.makeValidName(u_main{i_main})){i_subject} = nan(sum(mask),n_session,n_column);
            for i_session = 1:n_session
                ii_session = (t_session == u_session(i_session));
                for i_column = 1:n_column
                    ii_column = (t_column == u_column(i_column));
                    j_column = f_main(ii_session & ii_column);
                    file = fullfile(tcan.running.directory.copy.first.beta,tcan.running.design(i_subject).column.name{j_column},sprintf('subject_%03i session_%03i order_001.nii',tcan.running.subject.unique(i_subject),u_session(i_session)));
                    if file_match(file)
                        vol  = scan_nifti_load(file,mask);
                        roi.(matlab.lang.makeValidName(u_main{i_main})){i_subject}(:,i_session,i_column) = vol;
                    end
                end
            end
        end
    end
end
