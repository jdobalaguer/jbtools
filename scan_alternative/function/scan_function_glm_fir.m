
function scan = scan_function_glm_fir(scan)
    %% scan = SCAN_FUNCTION_GLM_FIR(scan)
    % define "fir" functions
    % to list main functions, try
    %   >> help scan;

    %% note
    % 1. something seems wrong. 'first:beta' and 'first:contrast' should be equivalent, but they're not.
    
    %% function
    if ~scan.running.flag.function, return; end
    
    scan_tool_print(scan,false,'\nAdd function (fir) : ');
    scan.function.fir = @auxiliar_fir;

    %% nested
    function fir = auxiliar_fir(varargin)
        fir = [];
        if nargin~=4 || strcmp(varargin{1},'help')
            scan_tool_help('fir = @fir(level,type,mask,contrast)','This function loads the [type] values estimated by the [level] analysis within a region of interest and a column/contrast for every [order] of your basis function. It''s particularly useful when using FIRs. [level] is a string {''first'',''second''}. [type] is a string {''beta'',''cont'',''spmt''}. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. [contrast] is a string with the name of the column/contrast. If no output is captured, the data is displayed within a figure.');
            return;
        end
        
        % default
        [level,type,mask,contrast] = deal(varargin{1:4});
        
        % assert
        if ~any(strcmp(level,{'first','second'})),              auxiliar_fir('help'); return; end
        if ~any(strcmp(type,{'beta','contrast','statistic'})),  auxiliar_fir('help'); return; end
        if ~ischar(mask),                                       auxiliar_fir('help'); return; end
        if ~ischar(contrast),                                   auxiliar_fir('help'); return; end
        
        % roi
        roi = scan.function.roi(level,type,mask);

        % switch
        switch [level,':',type]
            
            % first level beta
            case 'first:beta'
                for i_subject = 1:scan.running.subject.number
                    n_session = scan.running.subject.session(i_subject);
                    u_order   = unique(scan.running.design(i_subject).column.order(strcmp(contrast,scan.running.design(i_subject).column.name)));
                    n_order   = length(u_order);
                    fir(i_subject,:,1:n_order,1:n_session) = roi.(matlab.lang.makeValidName(contrast)){i_subject}; %#ok<*AGROW>
                end

            % first level contrast
            case 'first:contrast'
                for i_subject = 1:scan.running.subject.number
                    fir(i_subject,:,:) = roi.(matlab.lang.makeValidName(contrast)){i_subject};
                end

            % first level statistic
            case 'first:statistic'
                for i_subject = 1:scan.running.subject.number
                    fir(i_subject,:,:) = roi.(matlab.lang.makeValidName(contrast)){i_subject};
                end

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
        
        % plot
        if ~nargout,
            switch level
                case 'first'
                    fir = nanmean(fir,4);
                    fir = nanmean(fir,2);
                    [m,e] = deal(mat2vec(nanmean(fir,1))',mat2vec(nanste(fir,1))');
                    fig_figure();
                    fig_steplot(m,e);
                    fig_pipplot(m,e);
                    plot(zeros(size(m)),'k--');
                case 'second'
                    fir = meeze(fir,[2,4]);
                    fir = fir';
                    fig_figure();
                    plot(fir,'marker','.','color','b');
                    plot(zeros(size(fir)),'k--');
            end
        end
    end
end
