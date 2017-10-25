
function [h,s] = fig_ppbare(m,e,p,c,g,b,w,t)
    % Create bars with p-value indicators
    
    %% function
    
    % default
    func_default('e',[]);
    func_default('p',[]);
    func_default('c',[]);
    func_default('g',[]);
    func_default('b',[]);
    func_default('w',[]);
    func_default('t',{});
    
    % values
    h = fig_bare(m,e,c,g,b,w);
    
    % statistics
    s = struct();
    s.p  = p;
    
    % plot stars
    for i_group = 1:mat_size(m,2)
        for i_value = 1:mat_size(m,1)
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