function ret = mturk_concatall(s)
    u_field = fieldnames(s{1});
    nb_fields = length(u_field);
    nb_s = length(s);
    
    ret_cell = struct();
    ret      = struct();
    if ~nb_s
        return
    end
    
    % foreach field
    for i_field = 1:nb_fields
        this_field = u_field{i_field};
        % set cat dimension
        switch this_field
            case 'sdata'
                catdim = 1;
            case 'edata'
                catdim = 1;
            case 'parameters'
                catdim = 1;
            case 'numbers'
                catdim = 1;
            otherwise
                fprintf('mturk_concatall: WARNING. unknown field %s.   \n',this_field);
                fprintf('mturk_concatall: WARNING. default cat dim = 1.\n');
                catdim = 1;
        end
        
        % add subject
        if strcmp(this_field,'sdata')
            for i_s = 1:nb_s
                s{i_s}.(this_field) = add_subject(s{i_s}.(this_field));
            end
        end
        
        % foreach cell
        ret_cell.(this_field){1} = s{1}.(this_field);
        for i_s = 2:nb_s
            ret_cell.(this_field){i_s} = s{i_s}.(this_field);
        end
        ret.(this_field) = struct_concat(catdim,ret_cell.(this_field){:});
    end
end

function s = add_subject(s)
    if ~isfield(s,'vb_subject')
        s.vb_subject = repmat(randi(10000),size(s.vb_index));
    end
end