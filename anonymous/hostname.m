
function hn = hostname()
    assertUnix();
    [~,hn]  = system('hostname');
    hn(end) = [];
end
