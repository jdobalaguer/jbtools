
function html = d3_matdata(m,s)
    %% html = D3_MATDATA(vals,name)
    
    %% warnings
    %#ok<*AGROW>
    
    %% function
    html = '';
    
    try
        switch(class(m))
            case {'double','single','logical','int8','uint8','int16','uint16','int32','uint32','int64','uint64'}
                html = [html,s,' = [',sprintf('%.3f,',m),'];',10];
            case 'char'
                html = [html,s,' = "',m,'";',10];
            case 'cell'
                html = [html,s,' = [];',10];
                for i = 1:length(m)
                    html = [html,d3_matdata(m{i},[s,'[',num2str(i-1),']'])];
                end
            case 'struct'
                u = fieldnames(m);
                if isempty(u), return; end
                html = [html,s,' = {};',10];
                for i = 1:length(u)
                    html = [html,d3_matdata(m.(u{i}),[s,'["',u{i},'"]'])];
                end
            otherwise
                error('d3_matdata: error. data of class "%s" not accepted',d3_matdata);
        end
    catch ME
        disp(html);
        rethrow(ME);
    end

end