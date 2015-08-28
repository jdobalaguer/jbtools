
function scan = scan_autocomplete_mask(scan,image)
    %% scan = SCAN_AUTOCOMPLETE_MASK(scan)
    % autocomplete [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % variables
    switch image
        case {'image','realignment'}
            dirs = {image};
        case {'normalisation','smooth'}
            dirs = {image,sprintf('%d',scan.parameter.analysis.voxs)};
        otherwise
            scan_tool_error(scan,'image "%s" not valid',image);
    end
    
    % root
    scan.running.directory.mask.root   = scan.directory.mask;
    
    % common
    scan.running.directory.mask.common = file_endsep(fullfile(scan.running.directory.mask.root,'common',dirs{:}));
    
    % individual
    for i_subject = 1:scan.running.subject.number
        scan.running.directory.mask.individual{i_subject} = file_endsep(fullfile(scan.running.directory.mask.root,'individual',dirs{:},scan.parameter.path.subject{scan.running.subject.unique(i_subject)}));
    end
end
