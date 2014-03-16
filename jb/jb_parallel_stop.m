
function jb_parallel_stop()
    if exist('matlabpool','file') && matlabpool('size')
        matlabpool('close');
    end
end