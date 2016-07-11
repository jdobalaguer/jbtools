
function fig_slider(v,x,l,r)
    %% FIG_SLIDER(v[,x][,l][,r])
    % allows you to see data with many dimensions simultaneously
    % plot two dimensions at a time
    % v : matrix of values
    % x : cell of strings with the xticklabels
    % l : legend of each dimension
    % r : sprintf regular expression used for the sliders (default '%+.2f')
    
    %% function
    v = single(v);
    
    % number
    func_default('x',[]);
    func_default('l',[]);
    
    % parameters & variables
    n = max([length(x),length(l),ndims(v)]); % number of dimensions
    s = size(v);            % size
    s(end+1:n) = 1;
    
    m =  80;                % marge
    d =  30;                % distance between slides
    p = 150;                % text width
    w = 500 + 2*m;          % total width
    h = w + (n-2)*d + 2*m;  % total height
    
    t = [];                 % text handles
    b = [];                 % slider (button) handles
    f = [];                 % figure
    a = [];                 % axis
    
    % default
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
    for i_main = 3:n
        range = [1,s(i_main)];
        t(i_main-2) = uicontrol('Style','text','String',l{i_main},'Position',[m,m+d*(n-i_main),p,20]);
        if isscalar(x{i_main})
            b(i_main-2) = uicontrol('Style','text','String',x{i_main},'Position',[m+p,m+d*(n-i_main),w-2*m-p,20]);
        else
            b(i_main-2) = uicontrol('Style','slider','Min',range(1),'Max',range(2),'SliderStep',[1 1]./diff(range),'Value',1,'Position',[m+p,m+d*(n-i_main),w-2*m-p,20]);
            set(b(i_main-2),'Callback',@updateImage);
        end
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
        for i_nested = 3:n
            if ~isscalar(x{i_nested})
                set(t(i_nested-2),'String',sprintf(['%s = %s'],l{i_nested},x{i_nested}{get(b(i_nested-2),'Value')}));
            end
        end
        
        % retrieve indices
        c = cell(1,n-2);
        for i_nested = 3:n
            if isscalar(x{i_nested})
                c{i_nested-2} = 1;
            else
                c{i_nested-2} = get(b(i_nested-2),'Value');
            end
        end
        
        % plot
        plotImage(v(:,:,c{:}));
    end
    
    %% nested: plotImage
    function plotImage(values)
        
        % plot
        fig_pimage(values);
        colorbar();

        % aesthetics
        sa.clim   = ranger(v);
        if ~diff(sa.clim), sa.clim = sa.clim + [-eps('single'),+eps('single')]; end
        sa.ylabel = l{1};
        sa.xlabel = l{2};
        sa.xtick  = 1:s(2);
        sa.ytick  = 1:s(1);
        sa.xticklabel = x{2};
        sa.yticklabel = x{1};
        fig_axis(sa);
        fig_fontsize(a,14);
        fig_fontname(a,'Helvetica');
        set(gca,'XTickLabelRotation',90);
    end
end
