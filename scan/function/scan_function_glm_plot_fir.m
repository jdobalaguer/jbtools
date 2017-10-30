
function scan = scan_function_glm_plot_fir(scan)
    %% scan = SCAN_FUNCTION_GLM_PLOT_FIR(scan)
    % define function @get.fir
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function,   return; end
    if ~scan.running.flag.estimation, return; end
    scan.function.plot.fir = @auxiliar_fir;
end

%% auxiliar
function auxiliar_fir(varargin)
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin<5 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@plot.fir(scan,level,type,mask,contrast)','This function plots the average [type] values estimated by the [level] analysis within a region of interest and a column/contrast for every [order] of your basis function. It''s particularly useful when using FIRs. [level] is a string {''first'',''second''}. [type] is a string {''beta'',''cont'',''spmt''}. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. [contrast] is a string with the name of the column/contrast.');
        return;
    end

    % default
    [level,type,mask,contrast] = varargin{2:5};
    plot_args = struct_default(pair2struct(varargin{6:end}),scan_function_plot_args());

    % assert
    if ~any(strcmp(level,{'first','second'})),              auxiliar_fir(tcan,'help'); return; end
    if ~any(strcmp(type,{'beta','contrast','statistic'})),  auxiliar_fir(tcan,'help'); return; end
    if ~ischar(mask),                                       auxiliar_fir(tcan,'help'); return; end
    if ~ischar(contrast),                                   auxiliar_fir(tcan,'help'); return; end

    % fir
    fir = tcan.function.get.fir(tcan,level,type,mask,contrast);

    % plot
    if ~nargout
        switch level
            case 'first'
                fir = nanmean(fir,4);
                fir = nanmean(fir,2);
                [m,e] = deal(mat2vec(nanmean(fir,1))',mat2vec(nanste(fir,1))');
                x = linspace(0,tcan.job.basisFunction.parameters.length,tcan.job.basisFunction.parameters.order); %1:length(m);
                fig_figure(plot_args.figure);
                fig_combination({'marker'},x,m,e,plot_args.color_stroke);
                fig_spline({'shade','pip','line'},x,m,e,plot_args.color_stroke);
                plot([0,tcan.job.basisFunction.parameters.length],[0,0],'k--'); %plot(zeros(size(m)),'k--');
            case 'second'
                fir = meeze(fir,[2,4]);
                fir = fir';
                fig_figure(plot_args.figure);
                fig_combination('marker',[],fir,[],plot_args.color_stroke);
                fig_spline('line',[],fir,[],plot_args.color_stroke);
                plot(zeros(size(fir)),'k--');
        end
    end
end
