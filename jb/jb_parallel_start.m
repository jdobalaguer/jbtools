
function jb_parallel_start()
    if exist('matlabpool','file') && ~matlabpool('size')
        % profiles
        [~,profiles] = defaultParallelConfig();

        % janmanager
        if ismember('janmanager',profiles)
            pctconfig('portrange', [31000,32000]);
            matlabpool('janmanager');
        else
            matlabpool();
        end
    end
end
