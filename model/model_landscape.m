
function model_landscape(model,c_pars)
    %% model = MODEL_LANDSCAPE(model,pars)
    % see also: model_cost
    
    %% warnings
    %#ok<*ASGLU>
    
    %% assert
    
    %% function
    
    % figure
    h = fig_figure();
    
    % numbers
    n_cpars = length(c_pars);
    
    j_subplot = 0;
    for i_cpars = 1:n_cpars
        
        % numbers
        pars = unique(c_pars{i_cpars});
        s_comb  = size(model.cost.result.cost); s_comb(1:2) = [];
        n_index = length(model.cost.index);

        % find pars
        u_pars = fieldnames(model.simu.pars);
        n_pars = length(u_pars);
        f_pars = nan(1,length(pars));
        for i_pars = 1:length(pars)
            ii = strcmp(pars{i_pars},u_pars);
            assert(sum(ii)==1, 'model_landscape: error. pars "%s" not valid',pars{i_pars});
            f_pars(i_pars) = find(ii);
        end
        
        % assert
        assert(length(f_pars)<3, 'model_landscape: error. too many dimensions!');

        % squeeze
        cost = mean(model.cost.result.cost,1); ... subject
        for i = 1:n_pars
            if ~jb_anyof(i,f_pars)
                cost = min(cost,[],i+2);
            end
        end

        % plot
        for i_index = 1:n_index
            j_subplot = j_subplot + 1;
            subplot(n_cpars,n_index,j_subplot);
            imagesc(reshape(cost(1,i_index,:),s_comb(f_pars)))
            sa = struct();
            if i_cpars == 1, sa.title = sprintf('index %d',i_index); end
            sa.xtick      = 1:length(model.simu.pars.(u_pars{f_pars(2)}));
            sa.xticklabel = num2leg(model.simu.pars.(u_pars{f_pars(2)}),'%.2f');
            sa.xlabel     = u_pars{f_pars(2)};
            sa.ytick      = 1:length(model.simu.pars.(u_pars{f_pars(1)}));
            sa.yticklabel = num2leg(model.simu.pars.(u_pars{f_pars(1)}),'%.2f');
            sa.ylabel     = u_pars{f_pars(1)};
            fig_axis(sa);
            %set(gca(),'clim',[0,1]);
            colorbar();
        end
    end
    
end
