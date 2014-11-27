
function scan = scan_rsa_plot_rdm(scan)
    %% scan = SCAN__RSA_PLOT_RDM(scan)
    % Plot Representation Dissimilarity Matrix (RDM) for RSA
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    if ~isfield(scan.rsa,'plot'),     return; end
    if ~isfield(scan.rsa.plot,'rdm'), return; end
    if ~scan.rsa.plot.rdm,            return; end
    
    u_subject = scan.rsa.plot.subject;
    n_subject = length(u_subject);
    
    % main RDM (at the level of trials)
    fig_figure();
    for subject = u_subject
        i_subject = find(subject == scan.subject.u);
        subplot(n_subject,1,i_subject);
        imagesc(scan.rsa.variable.rdm{i_subject});
        sa.title = sprintf('subject %02i',u_subject(i_subject));
        fig_axis(sa);
        colorbar();
    end
    
    % shrinked RDMs
    fig_figure();
    j_subplot = 0;
    for subject = u_subject
        i_subject = find(subject == scan.subject.u);
        for i_regressor = 1:length(scan.rsa.regressor.name)
            j_subplot = j_subplot + 1;
            subplot(n_subject,length(scan.rsa.regressor.name),j_subplot);
            
            subrdm = scan.rsa.variable.subrdm{i_subject}{i_regressor};
            imagesc(subrdm.matrix);
            sa.title = sprintf('subject %02i regressor "%s"',subject,subrdm.name);
            sa.xtick      = 1:subrdm.size;
            sa.ytick      = 1:subrdm.size;
            sa.xticklabel = num2leg(subrdm.level);
            sa.yticklabel = num2leg(subrdm.level);
            fig_axis(sa);
            colorbar();
        end
    end
    
    % model RDMs
    fig_figure();
    j_subplot = 0;
    for subject = u_subject
        i_subject = find(subject == scan.subject.u);
        for i_model = 1:length(scan.rsa.variable.model{i_subject})
            j_subplot = j_subplot + 1;
            subplot(n_subject,length(scan.rsa.variable.model{i_subject}),j_subplot);
            
            model = scan.rsa.variable.model{i_subject}{i_model};
            imagesc(model.matrix);
            sa.title = sprintf('subject %02i model "%s"',subject,model.name);
            fig_axis(sa);
            colorbar();
        end
    end
    
end

