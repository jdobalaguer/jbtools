
function [obj] = new_parse(varargin)
    %% obj = NEW_PARSE(scan,file1,file2,...)

    %% function
    disp('new_parse');
    
    % scan
    scan = varargin{1};
    
    % files
    u_file = mat2vec(varargin(2:end));
    n_file = nargin-1;
    if n_file==1 && exist(u_file{1},'dir')==7 ... one directory
        u_file = file_endsep(u_file{1});
        u_file = file_list(fullfile(u_file,'*.nii'),'absolute');
        n_file = length(u_file);
    elseif ~n_file ... no arguments (current directory)
        u_file = file_list(fullfile(pwd(),'*.nii'),'absolute');
        n_file = length(u_file);
    else ... list of files
        scan_tool_assert(scan,all(cellfun(@file_exist,u_file)),'one or more files do not exist');
    end
    
    % save things
    obj = scan_view_obj();
    obj.scan = scan;
    obj.dat.statistics = struct('file',u_file);
end
