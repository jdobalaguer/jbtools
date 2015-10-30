
function fig_sliderr(v,e,x,l,r)
    %% FIG_SLIDERR(v[,e][,x][,l][,r])
    % allows you to see data with many dimensions simultaneously
    % plot one dimension at a time (and standard error bars)
    % v : matrix of values
    % e : matrix of error values
    % x : cell of strings with the xticklabels
    % l : legend of each dimension
    % r : sprintf regular expression used for the sliders (default '%+.2f')
    
    %% function
    
    % parameters & variables
    s = size(v);            % size
    n = ndims(v);           % number of dimensions
    
    m =  80;                % marge
    d =  30;                % distance between slides
    p = 150;                % text width
    w = 500 + 2*m;          % total width
    h = w + (n-1)*d + 2*m;  % total height
    
    t = [];                 % text handles
    b = [];                 % slider (button) handles
    f = [];                 % figure
    a = [];                 % axis
    
    % default
    func_default('e',zeros(size(v)));
    func_default('r','%.2f');
    func_default('x',arrayfun(@(x)num2leg(1:x,r),s,'UniformOutput',false));
    func_default('l',num2leg(1:n,'dim %d'));
    
    % cellnum to cellstr
    if ~iscell(x{1}), x = cellfun(@(x)num2leg(x,r),x,'UniformOutput',false); end
    
    % assert
    assert(all(cellfun(@iscellstr,x)),'fig_slider: error. [x] must be a cell of cells of strings');
    assert(iscellstr(l),              'fig_slider: error. [l] must be a cell of strings');
    
    % create figure
    f = figure('Resize','on','Position',[0,0,w,h],'Name',mfilename);
    set(f,'Color',[1,1,1]);
    set(f,'ToolBar','none');
    
    % create axes
    a = axes('position',[m/w,1-(w-m)/h,1-2*m/w,(w-2*m)/h]);
    
    % create text & buttons
    for i_main = 2:n
        range = [1,s(i_main)];
        t(i_main-1) = uicontrol('Style','text','String',l{i_main},'Position',[m,m+d*(n-i_main),p,20]);
        b(i_main-1) = uicontrol('Style','slider','Min',range(1),'Max',range(2),'SliderStep',[1 1]./diff(range),'Value',1,'Position',[m+p,m+d*(n-i_main),w-2*m-p,20]);
        set(b(i_main-1),'Callback',@updateImage);
    end
    
    % plot
    updateImage();
    
    %% nested: updateImage
    function updateImage(control,action) %#ok<INUSD>
        % only integer values
        if exist('control','var')
            set(control,'Value',round(get(control,'Value')));
        end
        
        % set axis
        axes(a);
        
        % update labels
        for i_nested = 2:n
            set(t(i_nested-1),'String',sprintf(['%s = %s'],l{i_nested},x{i_nested}{get(b(i_nested-1),'Value')}));
        end
        
        % retrieve indices
        c = cell(1,n-1);
        for i_nested = 2:n
            c{i_nested-1} = get(b(i_nested-1),'Value');
        end
        
        % plot
        plotImage(v(:,c{:}),e(:,c{:}));
    end
    
    %% nested: plotImage
    function plotImage(values,errors)
        % plot
        delete(get(a,'Children'));
        if any(e)
            fig_combination({'line','marker','shade','pip'},[],values,errors);
        else
            fig_combination({'line'},[],values,errors);
        end

        % aesthetics
        sa.ylim   = ranger(v) + [-1,+1]*nanmax(v(:));
        sa.xlabel = l{1};
        sa.xtick  = 1:s(1);
        sa.xticklabel = x{1};
        fig_axis(sa);
        fig_fontsize(a,14);
        fig_fontname(a,'Helvetica');
        set(gca,'XTickLabelRotation',90);
    end
end
