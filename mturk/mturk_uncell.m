function ret = mturk_uncell(c,h)
    try
        %% is a struct
        if isstruct(c)
            ret = struct();
            u_field = fieldnames(c);
            nb_fields = length(u_field);
            for i_field = 1:nb_fields
                this_field = u_field{i_field};
                ret.(this_field) = mturk_uncell(c.(this_field),[h,this_field]);
            end
            return;
        end

        %% is not a cell
        if ~iscell(c)
            ret = c;
            return
        end

        nb_cells = length(c);
        %% empty
        if ~nb_cells
            ret = [];
            return;
        end

        %% includes a string
        if iscellstr(c)
            ret = c';
            return;
        end

        %% includes another cell
        if all(cellfun(@iscell,c))
            for i_cell = 1:nb_cells
                c{i_cell} = mturk_uncell(c{i_cell},[h,{'{}'}]);
            end
        end    
        % includes a number
        if all(cellfun(@isnumeric,c))
            s_c = size(c{1});
            for i_c = 1:length(c)
                c{i_c} = reshape(c{i_c},[1,s_c]);
            end
            c = mat2vec(c);
            ret = cell2mat(c);
            ret = reshape(ret,[nb_cells,s_c]);
            return;
        end


        %% else
        ret = c;
    catch err
        for i = 1:length(h)
            fprintf('mturk_parseall: WARNING. dbstack = "%s" \n',h{i});
        end
        fprintf('mturk_parseall: WARNING (we will keep it as a cell). \n');
        ret = c;
    end
end