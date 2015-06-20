
function scan = scan_save_scan(scan)
    %% scan = SCAN_SAVE_SCAN(scan)
    % save the [scan] struct
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % flat scan
    flat    = struct_flat(scan);
    pair    = struct2pair(flat);
    u_field = pair(1:2:end);
    u_value = pair(2:2:end);
    byts    = bytes(u_value{:}); byts = round(100 * byts / sum(byts));
    
    % move previous folder
    if file_match(scan.running.directory.save.scan)
        d = dir(scan.running.directory.save.scan); d = d.date;
        f = strcat(file_nendsep(scan.running.directory.save.scan),' ',d);
        movefile(scan.running.directory.save.scan,f);
    end
    
    % make directory
    file_mkdir(fileparts(scan.running.directory.save.scan));
    
    % print
    scan_tool_print(scan,false,'\nSaving [scan] ');
    scan_tool_progress(scan,sum(byts));
    
    for i_field = 1:length(u_field)
        
        % variables
        var = u_field{i_field};
        val = flat.(var);
        file = fullfile(scan.running.directory.save.scan,strcat(u_field{i_field},'.mat'));

        % save
        try
            assert(~strncmp(u_field{i_field},'function',8));
            auxiliar_fast(file,val);
%                 scan_tool_warning(scan,true,'fast');
        catch e
%             scan_tool_warning(scan,false,sprintf('mess : %s',e.message));
%             scan_tool_warning(scan,false,sprintf('file : %s',e.stack(1).file));
%             scan_tool_warning(scan,false,sprintf('name : %s',e.stack(1).name));
%             scan_tool_warning(scan,true, sprintf('line : %d',e.stack(1).line));
            
            if bytes(val) < 2e9
                auxiliar_small(file,val);
%                 scan_tool_warning(scan,true,'small');
            else
                auxiliar_big(file,val);
%                 scan_tool_warning(scan,true,'big');
            end
        end
        
        % wait
        for i = 1:byts(i_field), scan_tool_progress(scan,[]); end
    end
    scan_tool_progress(scan,0);
end

%% auxiliar

function auxiliar_fast(file,val)
    % fastest method but doesn't work with everything
    val = hlp_serialize(val);
    s = struct('method',{'fast'},'value',{val});
    savefaststruct(file,s);
end

function auxiliar_small(file,val)
    % slow but reliable and non-compressed MATLAB v6 method
    s = struct('method',{'small'},'value',{val}); %#ok<NASGU>
    save(file,'-v6','-struct','s');
end

function auxiliar_big(file,val)
    % for >2G files, this MATLAB v7.3 method
    s = struct('method',{'big'},'value',{val}); %#ok<NASGU>
    save(file,'-v7.3','-struct','s');
end
