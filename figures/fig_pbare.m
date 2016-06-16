
function [h,s] = fig_pbare(x,c,g,b,w,t)
    % Create bars with p-value indicators
    
    %% function
    
    % default
    func_default('c',[]);
    func_default('g',[]);
    func_default('b',[]);
    func_default('w',[]);
    func_default('t',{});
    
    % values
    [m,e] = deeze(x,1);
    h = fig_bare(m,e,c,g,b,w);
    
    % return
    if ndims(x)>3, s = struct(); return; end
    
    % statistics
    [~,p,ci,s] = ttest(x,[],t{:});
    s.p  = p;
    s.ci = ci;
    
    % plot stars
    for i_group = 1:mat_size(x,3)
        for i_value = 1:mat_size(x,2)
            % get position
            px = h.errors(i_group).XData(i_value);
            py = h.errors(i_group).YData(i_value);
            pu = h.errors(i_group).UData(i_value);
            pl = h.errors(i_group).LData(i_value);
            pm = m(i_value,i_group);
            pe = e(i_value,i_group);
            ph = 'center';
            if pm+pe>0, pz=py+pu;        pv = 'bottom';
            else        pz=(py-pl)*1.05; pv = 'top';
            end
            % plot
            if 0.001 > s.p(1,i_value,i_group)
                f = text(px,pz,'***');
                set(f,'FontSize',20)
                set(f,'HorizontalAlignment',ph);
                set(f,'VerticalAlignment',  pv);
            elseif 0.01 > s.p(1,i_value,i_group)
                f = text(px,pz,'**');
                set(f,'FontSize',20)
                set(f,'HorizontalAlignment',ph);
                set(f,'VerticalAlignment',  pv);
            elseif 0.05 > s.p(1,i_value,i_group)
                f = text(px,pz,'*');
                set(f,'FontSize',20)
                set(f,'HorizontalAlignment',ph);
                set(f,'VerticalAlignment',  pv);
            end
        end
    end
    
end