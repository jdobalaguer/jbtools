function hn = hostname()
    hn = evalc('system(''hostname'');');
    hn(end) = [];
end
