
function scan = scan_save_hdd(scan,field,force,clear)
    %% scan = SCAN_SAVE_HDD(scan,field)
    % if the size of scan is bigger than [scan.parameter.analysis.hdd]
    % save some fields in the hard-drive in [scan.file.save.hdd] to free the RAM.
    % if [force]  is set to true, it will ignore the size of scan
    % if [clear]  is set to false, it won't remove the values from [scan]
    % scan  : [scan] struct
    % field : field(s) to be saved in the HDD
    % force : boolean, whether to force the save in disk (default false)
    % clear : boolean, whether to remove the field from scan (default true)
    
    %% function
    
    % default
    func_default('force',false);
    func_default('clear',true );
    
    % return
    if ~force && bytes(scan) < scan.parameter.analysis.hdd, return; end
    
    % warning
    scan_tool_warning(scan,false,'this has not been implemented yet.'); return;
    
    
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
