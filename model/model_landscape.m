
function model_landscape(model,c_pars)
    %% model = MODEL_LANDSCAPE(model,pars)
    % plot the landscape of the cost function across parameters
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
        pars = unique(c_pars{i_cpars},'stable');
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
        assert(length(f_pars)<4, 'model_landscape: error. too many dimensions!');

        % squeeze
        nan_cost  = model.cost.result.cost;
        nan_cost(isinf(nan_cost)) = nan;
        mean_cost = nanmean(nan_cost,1); % subject
        ste_cost  = nanste(nan_cost,1); % subject
        for i = 1:n_pars
            if ~ismember(i,f_pars)
                mean_cost = nanmin(mean_cost,[],i+2);
                ste_cost  = nanmin(ste_cost, [],i+2);
            end
        end

        % plot
        for i_index = 1:n_index
            j_subplot = j_subplot + 1;
            subplot(n_cpars,n_index,j_subplot);
            switch(length(f_pars))
                case 1
                    x = model.simu.pars.(u_pars{f_pars});
                    m = reshape(mean_cost(1,i_index,:),[s_comb(f_pars),1]);
                    e = reshape( ste_cost(1,i_index,:),[s_comb(f_pars),1]);
                    fig_combination({'marker','line','shade','pip'},x,m,e);
                    sa.xlabel     = u_pars{f_pars};
                    sa.ylabel     = 'cost';
                    fig_axis(sa);
                case 2
                    z = reshape(mean_cost(1,i_index,:),s_comb(sort(f_pars)));
                    [~,ii_fpars] = sort(f_pars,'ascend');
                    z = permute(z,ii_fpars);
                    fig_pimage(z);
                    sa = struct();
                    sa.xtick      = 1:length(model.simu.pars.(u_pars{f_pars(2)}));
                    sa.xticklabel = num2leg(model.simu.pars.(u_pars{f_pars(2)}),'%.2f');
                    sa.xlabel     = u_pars{f_pars(2)};
                    sa.xlim       = [0,s_comb(f_pars(2))+1];
                    sa.ytick      = 1:length(model.simu.pars.(u_pars{f_pars(1)}));
                    sa.yticklabel = num2leg(model.simu.pars.(u_pars{f_pars(1)}),'%.2f');
                    sa.ylabel     = u_pars{f_pars(1)};
                    sa.ylim       = [0,s_comb(f_pars(1))+1];
                    sa.ratio      = fliplr(s_comb(f_pars));
                    fig_axis(sa);
                    colorbar();
                case 3
                    z = reshape(mean_cost(1,i_index,:),s_comb(sort(f_pars)));
                    [~,ii_fpars] = sort(f_pars,'ascend');
                    z = permute(z,ii_fpars);
                    fig_4d(z,0.8);
                    sa.xtick      = 1:length(model.simu.pars.(u_pars{f_pars(2)}));
                    sa.xticklabel = num2leg(model.simu.pars.(u_pars{f_pars(2)}),'%.2f');
                    sa.xlabel     = u_pars{f_pars(2)};
                    sa.ytick      = 1:length(model.simu.pars.(u_pars{f_pars(1)}));
                    sa.yticklabel = num2leg(model.simu.pars.(u_pars{f_pars(1)}),'%.2f');
                    sa.ylabel     = u_pars{f_pars(1)};
                    sa.ztick      = 1:length(model.simu.pars.(u_pars{f_pars(3)}));
                    sa.zticklabel = num2leg(model.simu.pars.(u_pars{f_pars(3)}),'%.2f');
                    sa.zlabel     = u_pars{f_pars(3)};
                    fig_axis(sa);
                    colorbar();
            end
            if i_cpars == 1, title(sprintf('index %d',i_index)); end
        end
    end
    
end
