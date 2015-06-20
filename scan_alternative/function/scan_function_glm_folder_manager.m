
function scan = scan_function_glm_folder_manager(scan)
    %% scan = SCAN_FUNCTION_GLM_FOLDER_MANAGER(scan)
    % define function @folder.manager
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.folder.manager = @auxiliar_manager;

end

%% auxiliar
function auxiliar_manager(varargin)
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=3 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@folderManager(scan,mode,folder)','This function manipulates the folders "original" and "copy" in [scan.running.directory]. [mode] is the operation (''zip''/''unzip''/''delete''). [folder] is the target folder (e.g. ''original:first'' or ''copy:first:beta'' or ''copy:second:contrast'').');
        return;
    end

    % default
    [mode,folder] = varargin{2:3};

    % folder
    switch folder
        % mix of folders
        case 'original'
            auxiliar_manager(tcan,mode,'original:first');
            auxiliar_manager(tcan,mode,'original:second');
            return;
        case 'copy'
            auxiliar_manager(tcan,mode,'copy:first');
            auxiliar_manager(tcan,mode,'copy:second');
            return;
        case 'copy:first'
            auxiliar_manager(tcan,mode,'copy:first:beta');
            auxiliar_manager(tcan,mode,'copy:first:contrast');
            auxiliar_manager(tcan,mode,'copy:first:statistic');
            auxiliar_manager(tcan,mode,'copy:first:spm');
            return;
        case 'copy:second'
            auxiliar_manager(tcan,mode,'copy:second:beta');
            auxiliar_manager(tcan,mode,'copy:second:contrast');
            auxiliar_manager(tcan,mode,'copy:second:statistic');
            auxiliar_manager(tcan,mode,'copy:second:spm');
            return;
        case 'copy:beta'
            auxiliar_manager(tcan,mode,'copy:first:beta');
            auxiliar_manager(tcan,mode,'copy:second:beta');
            return;
        case 'copy:contrast'
            auxiliar_manager(tcan,mode,'copy:first:contrast');
            auxiliar_manager(tcan,mode,'copy:second:contrast');
            return;
        case 'copy:statistic'
            auxiliar_manager(tcan,mode,'copy:first:statistic');
            auxiliar_manager(tcan,mode,'copy:second:statistic');
            return;
        case 'copy:spm'
            auxiliar_manager(tcan,mode,'copy:first:spm');
            auxiliar_manager(tcan,mode,'copy:second:spm');
            return;
        % basic folders
        case 'original:first'
            u_directory = {tcan.running.directory.original.first};
        case 'original:second'
            u_directory = {tcan.running.directory.original.second};
        case 'copy:first:beta'
            u_directory = {tcan.running.directory.copy.first.beta};
        case 'copy:first:contrast'
            u_directory = {tcan.running.directory.copy.first.contrast};
        case 'copy:first:statistic'
            u_directory = {tcan.running.directory.copy.first.statistic};
        case 'copy:first:spm'
            u_directory = {tcan.running.directory.copy.first.spm};
        case 'copy:second:beta'
            u_directory = {tcan.running.directory.copy.second.beta};
        case 'copy:second:contrast'
            u_directory = {tcan.running.directory.copy.second.contrast};
        case 'copy:second:statistic'
            u_directory = {tcan.running.directory.copy.second.statistic};
        case 'copy:second:spm'
            u_directory = {tcan.running.directory.copy.second.spm};
        otherwise
            scan_tool_warning(tcan,false,'folder "%s" not valid',folder);
            auxiliar_manager(tcan,'help');
            return;
    end

    % mode
    for i = 1:length(u_directory)
        directory = file_nendsep(u_directory{i});
        zip_file  = sprintf('%s.zip',directory);
        switch mode
            case 'zip'
                if isempty(file_match(directory)), scan_tool_warning(tcan,false,'directory "%s" not found. nothing done.',directory); continue; end
                zip(zip_file,directory);
                file_rmdir(directory);
            case 'unzip'
                if isempty(file_match(zip_file)), scan_tool_warning(tcan,false,'zip-file "%s" not found. nothing done.',zip_file); continue; end
                unzip(zip_file,fileparts(directory));
                delete(zip_file);
            case 'delete'
                if isempty(file_match(directory)), scan_tool_warning(tcan,false,'directory "%s" not found. nothing done.',directory); continue; end
                file_rmdir(directory);
            otherwise
                scan_tool_warning(tcan,false,'mode "%s" not valid',mode)
                return;
        end
    end
end
