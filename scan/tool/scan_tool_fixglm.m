
function scan = scan_tool_fixglm(scan,proj)
    %% scan = SCAN_TOOL_FIXGLM(scan[,proj])
    % fix files and folders
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % default
    func_default('proj',file_name(scan.running.directory.job));
    
    % variables
    pwd_new = file_endsep(pwd());
    pwd_old = scan.directory.root;
    job_old = scan.running.directory.job;
    job_new = file_endsep(fullfile(file_parts(strrep(job_old,pwd_old,pwd_new)),proj));
    spm_old = scan.directory.spm;
    spm_new = file_endsep(fileparts(which('spm.m')));
    
    scan = nested(scan);
    
    %% nested
    function y = nested(x)
        switch class(x)
            case 'logical',         y = x;
            case 'uint64',          y = x;
            case 'single',          y = x;
            case 'double',          y = x;
            case 'function_handle', y = x;
            case 'MException',      y = x;
            case 'struct'
                switch numel(x)
                    case 0,         y = x;
                    case 1,         y = struct_func(@nested,x);
                    otherwise,      y = arrayfun(@nested,x,'UniformOutput',true);
                end
            case 'cell',            y = cellfun(@nested,x,'UniformOutput',false);
            case 'char'
                y = x;
                y = strrep(y,job_old,job_new);
                y = strrep(y,pwd_old,pwd_new);
                y = strrep(y,spm_old,spm_new);
            otherwise
                scan_tool_warning(scan,0,'class %s not taken care of',class(x));
                y = x;
        end
    end
end

