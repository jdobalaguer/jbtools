
function ii = anyof(v,u)
    %% ii = ANYOF(v,u)
    % logical array of items of [v] being equal to one of [u]
    % it's actually the same than ismember().

    %% function
    ii = ismember(v,u);
%     ii = false(size(v));
%     for i=1:length(u)
%         if iscellstr(v),    ii = ii | streq(v,u{i});
%         else                ii = ii | (v==u(i));
%         end
%     end
end
