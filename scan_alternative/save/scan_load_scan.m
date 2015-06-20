
function lcan = scan_load_scan(scan,scan_directory)
    %% scan = SCAN_LOAD_SCAN(scan)
    % load the [scan] struct
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % variables
    u_field = file_next(file_list(scan_directory,'local'));
    file    = file_list(scan_directory,'absolute');
    byts    = cellfun(@file_size,file);  byts = round(100 * byts / sum(byts));
    
    % print
    scan_tool_print(scan,false,'\nLoading [scan] ');
    scan_tool_progress(scan,sum(byts));
    
    lcan = struct();
    for i_field = 1:length(u_field)
        
        % variables
        var = u_field{i_field};
        [method,val] = file_loadvar(file{i_field},'method','value');
        
        % add in [lcan]
        switch method
            case 'fast'
                val = hlp_deserialize(val);
                lcan.(var) = val;
            case 'small'
                lcan.(var) = val;
            case 'big'
                lcan.(var) = val;
            otherwise
                scan_tool_error(scan,'method "%s" for field "%s" not recognised',method,strrep(var,'_','.'));
        end
        
        % wait
        for i = 1:byts(i_field), scan_tool_progress(scan,[]); end
    end
    scan_tool_progress(scan,0);
    
    % deepnes
    lcan = struct_deep(lcan);
end
