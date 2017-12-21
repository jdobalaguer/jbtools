
function scan = scan_save(scan)
    %% scan = SCAN_SAVE(scan)
    % save the [scan] struct
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % flat scan
    flat    = struct_flat(scan);
    pair    = struct2pair(flat);
    u_field = pair(1:2:end);
    u_value = pair(2:2:end);
    byts    = bytes(u_value{:}); byts = ceil(100 * byts / sum(byts));
    
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
    scan = scan_tool_progress(scan,sum(byts));
    
    for i_field = 1:length(u_field)
        
        % variables
        var = u_field{i_field};
        val = flat.(var);
        file = fullfile(scan.running.directory.save.scan,strcat(u_field{i_field},'.mat'));

        % save
        try
            % fprintf('%02i %d %s \n',byts(i_field),allow_serialize(flat.(u_field{i_field})),u_field{i_field}); continue;
            assert(allow_serialize(flat.(u_field{i_field})));
            assert(bytes(val) < 1e8);
            auxiliar_fast(file,val);
        catch
            if bytes(val) < 2e9,    auxiliar_small(file,val);
            else                    auxiliar_big(file,val);
            end
        end
        
        % wait
        for i = 1:byts(i_field), scan = scan_tool_progress(scan,[]); end
    end
    scan = scan_tool_progress(scan,0);
end

%% auxiliar
function b = allow_serialize(v)
    % can we serialize this variable?
    switch class(v)
        case {'double','single','logical','char','int8','uint8','int16','uint16','int32','uint32','int64','uint64'}, b = true;
        case 'cell',    b = all(mat2vec(cellfun(@allow_serialize,v)));
        case 'struct',  b = all(mat2vec(cellfun(@allow_serialize,struct2cell(v))));
        otherwise,      b = false;
    end
end

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
