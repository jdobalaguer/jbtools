
function h = fig_bare(m,e,c,g,b,w,l)
    %% h = FIG_BARE(values,errors,color,groups,bars,width,ylimit)
    % Create bars with standard errors
    % the error bar goes 1e up and 1e down

    %% function
    
    % variables
    n = size(m);
    r = isrow(m);

    % func_default
    func_default('e',zeros(size(m)));
    func_default('c',fig_color('w',n(2)));
    func_default('g','');
    func_default('b','');
    func_default('w',1);
    func_default('l',[0,max(mat2vec(m+e))]);

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
    assert(numel(l)==2,   'fig_bare:error. ylimit must have numel 2');
    
    % plot bars
    was_hold = ishold();
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
    if ~was_hold, hold('off'); end
    
    % groups
    t = get(gca(),'ticklength');
    set(gca(),'xtick',1:n(1),'xticklabel',g,'xaxislocation','top','ticklength',[0,t(2)]);
    
    % bars
    for i = 1:n(2)
        for j = 1:n(1)
            if ~isempty(b{i}), text(x(j,i),l(1)-0.05*diff(l), b{i}, 'Rotation', 45, 'HorizontalAlignment', 'right'); end
        end
    end
end
