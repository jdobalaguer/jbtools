
function varargout = scan_atlas_list(scan,atlas,map)
    %% [list] = SCAN_ATLAS_LIST(scan[,atlas][,map])
    % display or return a list of the atlases and regions
    % atlases must be installed first through scan_atlas_install
    % if no atlas is specified, [list] a list of the atlases
    % if an atlas but no map is specified, [list] a list of the maps
    % if an atlas and a map is specified, [list] a list of the ROI
    % to list main functions, try
    %   >> help scan;
    
    %% function
    varargout = {};
    
    % default
    func_default('atlas','');
    func_default('map',  '');
    
    % path
    path_private      = fullfile(scan_atlas_root(),'private');
    path_atlas        = file_endsep(fullfile(path_private,'atlas'));
    path_atlas_atlas  = file_endsep(fullfile(path_atlas,atlas));
    file_atlas        = fullfile(path_atlas_atlas,sprintf('%s.mat',map));
    
    if isempty(atlas)
        % list of atlases
        list = file_list(path_atlas);
    elseif isempty(map)
        % list of maps
        scan_tool_assert(scan,~isempty(file_match(path_atlas_atlas)),'atlas not found');
        list = file_name(file_list(fullfile(path_atlas_atlas,'*.mat')));
    else
        % list of regions
        scan_tool_assert(scan,~isempty(file_match(file_atlas)),'atlas/map not found');
        list = file_loadvar(file_atlas,'list');
        list = {list.label};
    end
    
    % remove empty and redundant
    list(cellfun(@isempty,list)) = [];
    list = unique(list,'stable');
    
    % return
    if nargout, varargout = {list}; return; end
    
    % display
    for i_list = 1:length(list)
        fprintf('%s \n',list{i_list});
    end

end