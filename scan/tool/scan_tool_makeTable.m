
function scan_tool_makeTable(SPM,csv_file) %#ok<INUSL>
    %% scan_tool_makeTable(SPM,csv_file)
    % write a CSV file with the table of activations
    
    %% build text description of activations
    evalc('[~,xSPM] = spm_getSPM(SPM);');
    txt = evalc('spm_list(''txtlist'',spm_list(''table'',xSPM))');
 
    %% parse spm text
 
    % find lines with statistics
    txt = strsplit(txt,'\n');
    txt(1) = []; txt(end) = [];
    assignbase txt
    f_spm = find(cellfun(@(s)strcmp(s,'--------------------------------------------------------------------------------'),txt));
    assert(length(f_spm)==2);
    txt = txt(f_spm(1)+1:f_spm(2)-2);
    txt = cellfun(@strtrim,txt,'UniformOutput',false);
    txt = cellfun(@strsplit,txt,'UniformOutput',false);
    txt{1}(1:2) = [];
 
    % align lines (when multiple peaks per cluster)
    for i = 1:length(txt)
        if (numel(txt{i}) == 8)
            txt{i} = {'','','','',txt{i}{:}};
        end
    end
 
    % transform into matrix
    txt = cat(1,txt{:});
 
    % filter columns
    f_spm = [2,    3,       6,       7,       8,       9,        10,       11,       12];
    l_spm = {'FDR','Voxels','Peak p','Peak t','Peak z','Uncor P','Coord x','Coord y','Coord z'};
    txt = txt(:,f_spm);
 
    % join coordinates
    txt(:,7) = strcat(txt(:,7),{';'},txt(:,8),{';'},txt(:,9));
    l_spm{7} = 'Coords';
    txt(:,8:9) = [];
    l_spm(8:9) = [];
 
    % write csv
    csv = [l_spm ; txt];
 
    % write
    file_delete(csv_file);
    file_mkdir(file_parts(csv_file));
    fid = fopen(csv_file, 'w');
    for i = 1:size(csv,1)
        fprintf(fid,'%s,', csv{i,1:end-1});
        fprintf(fid,'%s\n',csv{i,end});
    end
    fclose(fid);
 
end
