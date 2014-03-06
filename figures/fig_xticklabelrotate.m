function hText = fig_xticklabelrotate(XTick,rot,varargin)
    %%
    % hText = fig_xticklabelrotate(XTick,rot,XTickLabel,varargin)     Rotate XTickLabel
    %
    % Syntax: fig_xticklabelrotate
    %
    % Input:    
    % {opt}     XTick       - vector array of XTick positions & values (numeric) 
    %                           uses current XTick values or XTickLabel cell array by
    %                           default (if empty) 
    % {opt}     rot         - angle of rotation in degrees, 90° by default
    % {opt}     XTickLabel  - cell array of label strings
    % {opt}     [var]       - "Property-value" pairs passed to text generator
    %                           ex: 'interpreter','none'
    %                               'Color','m','Fontweight','bold'
    %
    % Output:   hText       - handle vector to text labels
    %
    % Example 1:  Rotate existing XTickLabels at their current position by 90°
    %    fig_xticklabelrotate
    %
    % Example 2:  Rotate existing XTickLabels at their current position by 45° and change
    % font size
    %    fig_xticklabelrotate([],45,[],'Fontsize',14)
    %
    % Example 3:  Set the positions of the XTicks and rotate them 90°
    %    figure;  plot([1960:2004],randn(45,1)); xlim([1960 2004]);
    %    fig_xticklabelrotate([1960:2:2004]);
    %
    % Example 4:  Use text labels at XTick positions rotated 45° without tex interpreter
    %    fig_xticklabelrotate(XTick,45,NameFields,'interpreter','none');
    %
    % Example 5:  Use text labels rotated 90° at current positions
    %    fig_xticklabelrotate([],90,NameFields);
    %
    % Note : you can not RE-RUN fig_xticklabelrotate on the same graph. 
    %
    
    %% check
    if isempty(get(gca,'XTickLabel')),
        error('fig_xticklabelrotate : can not process, either fig_xticklabelrotate has already been run or XTickLabel field has been erased')  ;
    end

    %% default
    is_rot          = (exist('rot','var')        && ~isempty(rot));
    is_xtick        = (exist('XTick','var')      && ~isempty(XTick));
    is_xticklabel   = (exist('XTickLabel','var') && ~isempty(XTickLabel));

    % rot
    if ~is_rot; rot=90; end

    % xtick
    if ~is_xtick; XTick = get(gca,'XTick'); end
    XTick = XTick(:);

    % xticklabel
    if ~is_xticklabel
        xTickLabels = get(gca,'XTickLabel');
        if ~iscell(xTickLabels); xTickLabels = deblank(num2cell(xTickLabels,2)); end
        varargin = varargin(2:length(varargin));	
    else
        if ~isempty(varargin) && iscell(varargin{1})
            xTickLabels = varargin{1};
            varargin(1) = [];
        else
            xTickLabels = num2str(XTick);
        end
    end

    % assert
    assert(length(XTick)==length(xTickLabels),'fig_xticklabelrotate : must have same number of elements in "XTick" and "XTickLabel"');

    %% add text
    % set & get
    set(gca,'XTick',XTick,'XTickLabel','')
    set(get(gca,'XLabel'),'Units','data');
    xLabelPosition = get(get(gca,'XLabel'),'Position');
    y = repmat(xLabelPosition(2),size(XTick,1),1);

    % text
    hText = text(XTick,y,xTickLabels,'fontsize',get(gca,'fontsize'));
    xAxisLocation = get(gca,'XAxisLocation');  
    if strcmp(xAxisLocation,'bottom');  set(hText,'Rotation',rot,'HorizontalAlignment','right',varargin{:});
    else                                set(hText,'Rotation',rot,'HorizontalAlignment','left',varargin{:});
    end

    
    % set & get
    set(get(gca,'xlabel'),'units','data');
    set(get(gca,'ylabel'),'units','data');
    set(get(gca,'title'), 'units','data');
    labxorigpos_data = get(get(gca,'xlabel'),'position');
    labyorigpos_data = get(get(gca,'ylabel'),'position');
    labtorigpos_data = get(get(gca,'title'), 'position');
    set(gca,'units','pixel')                        ;
    set(hText,'units','pixel')                      ;
    set(get(gca,'xlabel'),'units','pixel')          ;
    set(get(gca,'ylabel'),'units','pixel')          ;
    origpos = get(gca,'position')                   ;

    % textsizes
    textsizes = get(hText,'extent');  
    if iscell(textsizes); textsizes = cell2mat(textsizes); end
    largest =  max(textsizes(:,3))                  ;
    longest =  max(textsizes(:,4))                  ;

    %% position
    % extent and position
    laborigpos = get(get(gca,'xlabel'),'position')  ;
    labyorigext = get(get(gca,'ylabel'),'extent')   ;
    labyorigpos = get(get(gca,'ylabel'),'position') ;
    leftpos = get(hText(1),'position')              ;
    leftext = get(hText(1),'extent')                ;
    leftdist = leftpos(1) + leftext(1)              ;
    if leftdist > 0; leftdist = 0; end

    % newpos
    if strcmp(xAxisLocation,'bottom')  
        newpos = [origpos(1)-(min(leftdist,labyorigpos(1)))+labyorigpos(1) ...
                origpos(2)+((longest+laborigpos(2))-get(gca,'FontSize')) ...
                origpos(3)-(min(leftdist,labyorigpos(1)))+labyorigpos(1)-largest ...
                origpos(4)-((longest+laborigpos(2))-get(gca,'FontSize'))]  ;
    else
        newpos = [origpos(1)-(min(leftdist,labyorigpos(1)))+labyorigpos(1) ...
                origpos(2) ...
                origpos(3)-(min(leftdist,labyorigpos(1)))+labyorigpos(1)-largest ...
                origpos(4)-(longest)+get(gca,'FontSize')]  ;
    end
    set(gca,'position',newpos)                      ;

    % readjust position of text labels after resize of plot
    set(hText,'units','data')                       ;
    for loop= 1:length(hText); set(hText(loop),'position',[XTick(loop), y(loop)]); end

    % adjust position of xlabel and ylabel
    laborigpos = get(get(gca,'xlabel'),'position')  ;
    set(get(gca,'xlabel'),'position',[laborigpos(1) laborigpos(2)-longest 0])   ;

    % switch to data coord and fix it all
    set(get(gca,'ylabel'),'units','data')                   ;
    set(get(gca,'ylabel'),'position',labyorigpos_data)      ;
    set(get(gca,'title'),'position',labtorigpos_data)       ;

    set(get(gca,'xlabel'),'units','data')                   ;
        labxorigpos_data_new = get(get(gca,'xlabel'),'position')  ;
    set(get(gca,'xlabel'),'position',[labxorigpos_data(1) labxorigpos_data_new(2)])   ;

    % Reset all units to normalized to allow future resizing
    set(get(gca,'xlabel'),'units','normalized')          ;
    set(get(gca,'ylabel'),'units','normalized')          ;
    set(get(gca,'title'),'units','normalized')          ;
    set(hText,'units','normalized')                      ;
    set(gca,'units','normalized')                        ;

    %% output
    if nargout < 1; clear hText; end
end

