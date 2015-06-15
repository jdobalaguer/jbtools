
function hn = hostname()
    assertUnix();
    hn = evalc('system(''hostname'');');
    hn(end) = [];
end
