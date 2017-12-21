
function scan = scan_function_glm_get_fir(scan)
    %% scan = SCAN_FUNCTION_GLM_GET_FIR(scan)
    % define function @get.fir
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function,   return; end
    if ~scan.running.flag.estimation, return; end
    scan.function.get.fir = @auxiliar_fir;
end

%% auxiliar
function varargout = auxiliar_fir(varargin)
    varargout = cell(1,nargin);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=5 || strcmp(varargin{2},'help')
        varargout = {};
        scan_tool_help(tcan,'fir = @get.fir(scan,level,type,mask,contrast)','This function loads the [type] values estimated by the [level] analysis within a region of interest and a column/contrast for every [order] of your basis function. It''s particularly useful when using FIRs. [level] is a string {''first'',''second''}. [type] is a string {''beta'',''cont'',''spmt''}. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. [contrast] is a string with the name of the column/contrast.');
        return;
    end

    % default
    [level,type,mask,contrast] = varargin{2:5};

    % assert
    if ~any(strcmp(level,{'first','second'})),              auxiliar_fir(tcan,'help'); return; end
    if ~any(strcmp(type,{'beta','contrast','statistic'})),  auxiliar_fir(tcan,'help'); return; end
    if ~ischar(mask),                                       auxiliar_fir(tcan,'help'); return; end
    if ~ischar(contrast),                                   auxiliar_fir(tcan,'help'); return; end

    % roi
    roi = tcan.function.get.roi(tcan,level,type,mask);

    % switch
    fir = [];
    switch [level,':',type]

        % first level beta
        case 'first:beta'
            for i_subject = 1:tcan.running.subject.number
                [u_session,n_session] = numbers(tcan.running.subject.session{i_subject});
                u_order   = unique(tcan.running.design(i_subject).column.order(strcmp(contrast,tcan.running.design(i_subject).column.name)));
                n_order   = length(u_order);
                fir(i_subject,:,1:n_order,1:n_session) = roi.(matlab.lang.makeValidName(contrast)){i_subject}; %#ok<*AGROW>
            end

        % first level contrast
        case 'first:contrast'
            for i_subject = 1:tcan.running.subject.number, fir(i_subject,:,:) = roi.(matlab.lang.makeValidName(contrast)){i_subject}; end

        % first level statistic
        case 'first:statistic'
            for i_subject = 1:tcan.running.subject.number, fir(i_subject,:,:) = roi.(matlab.lang.makeValidName(contrast)){i_subject}; end

        % second level beta
        case 'second:beta'
            fir(1,:,:) = roi.(matlab.lang.makeValidName(contrast));

        % second level contrast
        case 'second:contrast'
            fir(1,:,:) = roi.(matlab.lang.makeValidName(contrast));

        % second level statistic
        case 'second:statistic'
            fir(1,:,:) = roi.(matlab.lang.makeValidName(contrast));
    end

    % return
    varargout = {fir};
end
