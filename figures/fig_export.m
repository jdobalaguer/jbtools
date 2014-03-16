
function fig_export(fname,handle)
    if ~exist('handle','var'); handle = gcf(); end
    
    %% find
    
    % extension
    extension = '';
    i_fname = length(fname);
    while i_fname>0 && (fname(i_fname)~='.')
        i_fname = i_fname - 1;
    end
    if ~i_fname
        extension = '.pdf';
        fname = [fname,extension];
    else
        extension = fname(i_fname:end);
    end
    
    %% set
    % handle
    handle = ['-f',num2str(handle)];
    
    % extension
    extension(1) = []; % remove dot
    if strcmp(extension,'jpg'); extension = 'jpeg'; end
    extension = ['-d',extension];
    
    %% print
    print(handle,extension,fname);

end

