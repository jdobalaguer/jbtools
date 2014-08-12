
function finish()
    assert(numel(dbstack())==1,'finish: error. MATLAB exit/quit functions can only run from commad window');
end