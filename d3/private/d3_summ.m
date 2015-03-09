
function [data,summ] = d3_summ(data)
    %% data = D3_SUMM(data)
    
    %% warnings
    %#ok<*AGROW>
    
    %% function
    
    % get tabs
    for i_data = 1:length(data), x_tab(i_data) = data(i_data).fig.handle; end
    [u_tab,n_tab] = numbers(x_tab);
    
    % summary
    for i1_tab = 1:n_tab
        f_tab = find(x_tab == u_tab(i1_tab));
        
        clear fig_handle fig_size_x fig_size_y;
        clear vals_rng_x vals_rng_y;
        clear axis_rng_x axis_rng_y;
        for i2_tab = 1:length(f_tab)
            data(f_tab(i2_tab)).fig.number = i1_tab;
            data(f_tab(i2_tab)).fig.layer  = i2_tab;
            data(f_tab(i2_tab)).fig.data   = f_tab(i2_tab);
            
            fig_handle(i2_tab)   = data(f_tab(i2_tab)).fig.handle;
            fig_size_x(i2_tab)   = data(f_tab(i2_tab)).fig.size.x;
            fig_size_y(i2_tab)   = data(f_tab(i2_tab)).fig.size.y;
            vals_rng_x(i2_tab,:) = ranger(data(f_tab(i2_tab)).vals.x);
            vals_rng_y(i2_tab,:) = ranger(data(f_tab(i2_tab)).vals.y);
            axis_rng_x(i2_tab,:) = data(f_tab(i2_tab)).axis.rng.x;
            axis_rng_y(i2_tab,:) = data(f_tab(i2_tab)).axis.rng.y;
        end
        summ.fig.handle(i1_tab)   = unique(fig_handle);
        summ.fig.size.x(i1_tab)   = nanmax(fig_size_x);
        summ.fig.size.y(i1_tab)   = nanmax(fig_size_y);
        summ.vals.rng.x(i1_tab,:) = mixnmax(vals_rng_x);
        summ.vals.rng.y(i1_tab,:) = mixnmax(vals_rng_y);
        summ.axis.rng.x(i1_tab,:) = mixnmax(axis_rng_x);
        summ.axis.rng.y(i1_tab,:) = mixnmax(axis_rng_y);
        summ.axis.rng.x(i1_tab,isnan(summ.axis.rng.x(i1_tab,:))) = summ.vals.rng.x(i1_tab,isnan(summ.axis.rng.x(i1_tab,:)));
        summ.axis.rng.y(i1_tab,isnan(summ.axis.rng.y(i1_tab,:))) = summ.vals.rng.y(i1_tab,isnan(summ.axis.rng.y(i1_tab,:)));
    end
end

%% auxiliar
function r = mixnmax(v)
    vmin = nanmin(v(:,1),[],1);
    vmax = nanmax(v(:,2),[],1);
    r    = [vmin,vmax];
end