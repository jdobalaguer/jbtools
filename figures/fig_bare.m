
function h = fig_bare(m,e,c,g,b,w)
    %% h = FIG_BARE(values,errors,color,groups,bars,width)
    % Create bars with standard errors
    % the error bar goes 1e up and 1e down

    %% function
    
    % variables
    n = size(m);
    r = isrow(m);

    % func_default
    func_default('c',fig_color('hsv',n(2)));
    func_default('g','');
    func_default('b','');
    func_default('w',1);

    % assert
    assertSize(m,e);

    %  transform
    if ischar(c),       c = fig_color(c,n(2));    end
    if isrow(c),        c = repmat(c,n(2),1);     end
    if ischar(b),       b = {b};                  end
    if isscalar(b),     b = repmat(b,[1,n(2)]);   end
    if ischar(g),       g = {g};                  end
    if isscalar(g),     g = repmat(g,[1,n(1)]);   end
    assert(iscellstr(g),'fig_bare: error. [groups] must be a cell of strings');
    assert(iscellstr(b),'fig_bare: error. [bars] must be a cell of strings');
    assert(numel(g)==n(1),'fig_bare:error. non-consistent length of [groups]');
    assert(numel(b)==n(2),'fig_bare:error. non-consistent length of [bars]');
    
    % plot bars
    hold('on');
    if r
        for i = 1:n(2)
            h.bars(i) = bar(i,m(i),w,'edgecolor','k','linewidth',2);
            h.bars(i).FaceColor = c(i,:);
        end
    else
        h.bars = bar(m,w,'edgecolor','k','linewidth',2);
        for i = 1:n(2)
            h.bars(i).FaceColor = c(i,:);
        end
        drawnow();
    end
    
    % plot errors
    x = nan(n);
    if r
        x = 1:n(2);
        h.errors = errorbar(x,m,e,'k','linestyle', 'none','linewidth',2);
    else
        for i = 1:n(2)
            if ~verLessThan('matlab', '8.4')
                x(:,i) = h.bars(i).XData + h.bars(i).XOffset;
           else
                x(:,i) = get(get(h.bars(i),'children'), 'xdata');
                x(:,i) = mean(x([1 3],:));
            end        
        end
        h.errors = errorbar(x,m,e,'k','linestyle', 'none','linewidth',2);
    end
    hold('off');
    
    % groups
    t = get(gca(),'ticklength');
    set(gca(),'xtick',1:n(1),'xticklabel',g,'xaxislocation','top','ticklength',[0,t(2)]);
    
    % bars
    for i = 1:n(2)
        for j = 1:n(1)
            if ~isempty(b{i}), text(x(j,i),-0.2, b{i}, 'Rotation', 45, 'HorizontalAlignment', 'right'); end
        end
    end
end
