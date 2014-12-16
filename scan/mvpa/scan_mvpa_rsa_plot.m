
function scan = scan_mvpa_rsa_plot(scan)
    %% scan = SCAN_MVPA_RSA_PLOT(scan)
    % Plot Representation Dissimilarity Matrix (RDM) for RSA
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*FNDSB,*AGROW>
    
    %% FUNCTION
    if ~isfield(scan.mvpa,'plot'),           return; end
    if ~isfield(scan.mvpa.plot,'subject'),   return; end
    
    do_subject   = ~isempty(scan.mvpa.plot.subject);
    do_average   = scan.mvpa.plot.average;
    u_subject    = scan.subject.u;
    n_subject    = scan.subject.n;
    u_plot_sub   = scan.mvpa.plot.subject;
    n_plot_sub   = length(u_plot_sub);
    
    % main RDM (at the level of trials)
    if scan.mvpa.plot.flag(1),
        
        % individual
        if do_subject
            fig_figure();
            j_subplot = 0;
            for i_subject = 1:n_subject
                subject = u_subject(i_subject);
                if any(subject == u_plot_sub)
                    j_subplot = j_subplot + 1;
                    subplot(n_plot_sub,1,j_subplot);
                    imagesc(scan.mvpa.variable.rdm{i_subject});
                    sa = struct();
                    sa.title = sprintf('subject %02i',subject);
                    fig_axis(sa);
                    colorbar();
                end
            end
        end
    end
    
    % shrinked RDMs
    if scan.mvpa.plot.flag(2),
        n_regressor = length(scan.mvpa.regressor.name);
        
        all_mats  = {};
        all_size  = {};
        all_level = {};
        all_name  = {};
        for i_regressor = 1:n_regressor
            all_size{ i_regressor} = scan.mvpa.variable.subrdm{1}{i_regressor}.size;
            all_level{i_regressor} = scan.mvpa.variable.subrdm{1}{i_regressor}.level;
            all_name{ i_regressor} = scan.mvpa.variable.subrdm{1}{i_regressor}.name;
            for i_subject = 1:n_subject
                all_mats{ i_regressor}(i_subject,:,:) = scan.mvpa.variable.subrdm{i_subject}{i_regressor}.matrix;
            end
        end
        
        % individual
        if do_subject
            fig_figure();
            j_subplot = 0;
            for i_subject = 1:n_subject
                subject = u_subject(i_subject);
                for i_regressor = 1:n_regressor
                    if any(subject == u_plot_sub)
                        j_subplot = j_subplot + 1;
                        subplot(n_plot_sub,n_regressor,j_subplot);

                        subrdm = scan.mvpa.variable.subrdm{i_subject}{i_regressor};

                        imagesc(subrdm.matrix);
                        sa = struct();
                        sa.title = sprintf('%02i "%s"',subject,subrdm.name);
                        sa.xtick      = 1:subrdm.size;
                        sa.ytick      = 1:subrdm.size;
                        sa.xticklabel = num2leg(subrdm.level);
                        sa.yticklabel = num2leg(subrdm.level);
                        fig_axis(sa);
                        colorbar();
                    end
                end
            end
        end
        
        % average
        if do_average
            fig_figure();
            for i_regressor = 1:n_regressor
                subplot(n_regressor,1,i_regressor);
                
                subrdm.matrix = meeze(all_mats{i_regressor},1);
                
                imagesc(subrdm.matrix);
                sa = struct();
                sa.title = sprintf('%02i "%s" average',i_regressor,all_name{i_regressor});
                sa.xtick      = 1:all_size{i_regressor};
                sa.ytick      = 1:all_size{i_regressor};
                sa.xticklabel = num2leg(all_level{i_regressor});
                sa.yticklabel = num2leg(all_level{i_regressor});
                fig_axis(sa);
                colorbar();
            end
        end
    end
    
    % model RDMs
    if scan.mvpa.plot.flag(3),
        n_model = length(scan.mvpa.variable.model{1});
        
        % individual
        if do_subject
            fig_figure();
            j_subplot = 0;
            for i_subject = 1:n_subject
                subject = u_subject(i_subject);
                for i_model = 1:n_model
                    if any(subject == u_plot_sub)
                        j_subplot = j_subplot + 1;
                        subplot(n_plot_sub,length(scan.mvpa.variable.model{i_subject}),j_subplot);

                        model = scan.mvpa.variable.model{i_subject}{i_model};

                        imagesc(model.matrix);
                        sa = struct();
                        sa.title = sprintf('%02i "%s"',subject,model.name);
                        fig_axis(sa);
                        colorbar();
                    end
                end
            end
        end
    end

end

