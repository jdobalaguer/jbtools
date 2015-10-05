
function lcan = scan_load(scan,scan_directory)
    %% scan = SCAN_LOAD(scan)
    % load the [scan] struct
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % variables
    scan_directory = file_endsep(scan_directory);
    u_field = file_next(file_list(scan_directory,'local'));
    scan_tool_assert(scan,~isempty(u_field),'nothing found in folder "%s"',scan_directory);
    file    = file_list(scan_directory,'absolute');
    scan_tool_assert(scan,all(strcmp(file_ext(file),'.mat')),'one or more files is not a mat-file');
    
    % load
    lcan = struct();
    for i_field = 1:length(u_field)
        
        try
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
        catch err
            scan_tool_warning(scan,false,err.message);
        end
    end
    
    % deepness
    lcan = struct_deep(lcan);
end
