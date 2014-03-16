
function jb_parallel_stop()
    if exist('matlabpool','builtin') && matlabpool('size')
        matlabpool('close');
    end
end