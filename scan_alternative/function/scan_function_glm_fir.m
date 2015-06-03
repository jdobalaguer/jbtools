
function scan = scan_function_glm_fir(scan)
    %% scan = SCAN_FUNCTION_GLM_FIR(scan)
    % define "fir" functions
    % to list main functions, try
    %   >> help scan;

    %% function
    scan_tool_print(scan,false,'\nAdd function (fir) : ');
    scan.function.fir = @auxiliar_fir;

    %% nested
    function fir = auxiliar_fir(level,type,mask,contrast)
        
        % assert
        scan_tool_assert(scan,any(strcmp(level,{'first','second'})),                    'fir = fir(level,type,roi,contrast)');
        scan_tool_assert(scan,any(strcmp(type,{'beta','contrast','statistic','spm'})),  'fir = fir(level,type,roi,contrast)');
        scan_tool_assert(scan,ischar(mask),                                             'fir = fir(level,type,roi,contrast)');
        scan_tool_assert(scan,ischar(contrast),                                         'fir = fir(level,type,roi,contrast)');
        
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
                    fir(i_subject,:,1:n_order,1:n_session) = roi.(contrast){i_subject};
                end
                if ~nargout,
                    fir = meeze(fir,[2,4]);
                    [m,e] = deal(mean(fir,1),ste(fir,1));
                    fig_figure();
                    fig_steplot(m,e);
                    fig_pipplot(m,e);
                end

            % first level contrast
            case 'first:contrast'
                scan_tool_error(scan,'this function is not ready yet..');

            % first level statistic
            case 'first:statistic'
                scan_tool_error(scan,'this function is not ready yet..');

            % second level beta
            case 'second:beta'
                scan_tool_error(scan,'this function is not ready yet..');

            % second level contrast
            case 'second:contrast'
                scan_tool_error(scan,'this function is not ready yet..');

            % second level statistic
            case 'second:statistic'
                scan_tool_error(scan,'this function is not ready yet..');
        end
    end
end
