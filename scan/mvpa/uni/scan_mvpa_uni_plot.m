

function scan = scan_mvpa_uni_plot(scan)
    %% scan = SCAN_MVPA_UNI(scan)
    % plot univariate effects
    % see scan_mvpa_uni
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % get values
    n_regressor = length(scan.mvpa.regressor.level);
    x_level = {};
    for i_regressor = 1:n_regressor
        [u_level,n_level] = numbers(jb_filter(scan.mvpa.regressor.level{i_regressor}(~scan.mvpa.regressor.discard)));
        assert(~any(isnan(u_level)),'scan_mvpa_uni_plot: error. some nan within regressor %d "%s"',i_regressor,scan.mvpa.regressor.name{i_regressor});
        x_level{i_regressor} = nan(scan.subject.n,n_level);
        for i_subject = 1:scan.subject.n
            beta = scan.mvpa.variable.beta{i_subject};
            assert(size(beta,1) == 1, 'scan_mvpa_uni_plot: error. multiple voxels');
            [u_session,n_session] = numbers(scan.mvpa.variable.regressor{i_subject}{i_regressor}.session);
            m_level = nan(n_session,n_level);
            for i_session = 1:n_session
                for i_level = 1:n_level
                    ii_session = (scan.mvpa.variable.regressor{i_subject}{i_regressor}.session == u_session(i_session));
                    ii_level   = (scan.mvpa.variable.regressor{i_subject}{i_regressor}.level   == u_level(i_level));
                    assert(length(ii_level & ii_session) == length(beta), 'scan_mvpa_uni_plot: error. mismatch length');
                    m_level(i_session,i_level) = mean(beta(:,ii_level & ii_session),2);
                end
            end
            x_level{i_regressor}(i_subject,:) = meeze(m_level,1);
        end
    end
    
    % plot values
    fig_figure();
    for i_regressor = 1:n_regressor
        if ~isfield(scan.mvpa,'plot') || ~isfield(scan.mvpa.plot,'dimension')
            scan.mvpa.plot.dimension = 'horizontal';
        end
        switch(scan.mvpa.plot.dimension)
            case 'horizontal'
                subplot(1,n_regressor,i_regressor);
            case 'vertical'
                subplot(n_regressor,1,i_regressor);
        end
        [u_level,~] = numbers(jb_filter(scan.mvpa.regressor.level{i_regressor}(~scan.mvpa.regressor.discard)));
        m = nanmean(x_level{i_regressor},1);
        e = nanste( x_level{i_regressor},1);
        
        % remove nan
        ii_nan = isnan(m);
        u_level(ii_nan) = [];
        n_level = length(u_level);
        m(ii_nan) = [];
        e(ii_nan) = [];
        
        % plot
        web = fig_barweb(   m,...                                                   mean
                            e,...                                                   error
                            [],...                                                  width
                            {''},...                                                group names
                            scan.mvpa.regressor.name{i_regressor},...               title
                            [],...                                                  xlabel
                            'beta weights',...                                      ylabel
                            fig_color('bw',n_level)./255,...                        colour
                            [],...                                                  grid
                            num2leg(u_level),...                                    legend
                            [],...                                                  error sides (1, 2)
                            'axis'...                                               legend ('plot','axis')
                            );

%         fig_steplot(u_level,m,e);
        
    end
    
    % figure name
    set(gcf,'Name',scan.mvpa.mask{1});
end
