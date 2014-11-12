
function scan_plot_peristimulus_1(scan,directory)
    %% SCAN_PLOT_PERISTIMULUS_B1(SCAN,DIRECTORY)
    % Plot peristimulus BOLD signal (1st level)
    % (after running "scan_glm_run" with scan.glm.function = 'fir')
    % see also scan_plot_peristimulus
    
    %% WARNINGS
    %#ok<*ERTAG,*FPARK>

    %% FUNCTION
    fig_figure();
    hold on;
    colours = fig_color('hsv',length(scan.glm.plot.contrast))./255;
    handles = nan(1,length(scan.glm.plot.contrast));
    for i_contrast = 1:length(scan.glm.plot.contrast)
        % assert
        assert(strcmp(scan.glm.function,'fir'),    'scan_plot_peristimulus_b1: error. glm function is not "fir"');
        assert(isfield(scan.glm.plot,'mask'),      'scan_plot_peristimulus_b1: error. no mask specified');
        dire_contrast = dir([directory,scan.glm.plot.contrast{i_contrast},'*']);
        dire_contrast = strcat(directory,strvcat(dire_contrast.name),filesep);
        scan.glm.plot.time = linspace(0,scan.glm.fir.len,scan.glm.fir.ord) - scan.glm.delay;
        assert(size(dire_contrast,1) == length(scan.glm.plot.time),sprintf('scan_plot_peristimulus_b1: error. n_order(%d) and n_time(%d) not consistent',size(dire_contrast,1),length(scan.glm.plot.time)));

        % load mask
        scan.file.plot_mask = [scan.dire.mask,scan.glm.plot.mask,'.img'];
        mask = spm_vol(scan.file.plot_mask);
        mask = double(mask.private.dat);
        mask = logical(mask(:));

        % values
        values = nan(scan.subject.n , length(scan.glm.plot.time));
        for i_time = 1:size(dire_contrast,1)
            dire_time = strtrim(dire_contrast(i_time,:));
            file_subject = dir([dire_time,'*_sub*_*.',scan.glm.plot.extension]);
            file_subject = strcat(dire_time,strvcat(file_subject.name));
            value = nan(1,size(file_subject,1));
            for i_subject = 1:size(file_subject,1)
                fil_subject = strtrim(file_subject(i_subject,:));
                nii = spm_vol(fil_subject);
                nii = double(nii.private.dat);
                nii = nii(mask);
                value(i_subject) = nanmean(nii(:));
            end
            values(:,i_time) = value;
        end

        % plot
        plot(scan.glm.plot.time,zeros(size(scan.glm.plot.time)),'--k');
        fig_steplot(scan.glm.plot.time,mean(values),ste(values),colours(i_contrast,:));
        handles(i_contrast) = fig_plot(scan.glm.plot.time,mean(values),'Color',colours(i_contrast,:));
    end
    % figure
    sa.title        = strrep(sprintf('peristimulus time statistics (%s)',scan.glm.plot.mask),'_',' ');
    sa.xlim         = ranger(scan.glm.plot.time) + [-1,+1];
    sa.xtick        = scan.glm.plot.time;
    sa.xticklabel   = num2leg(scan.glm.plot.time);
    sa.xlabel       = 'time (sec)';
    sa.ilegend      = handles;
    sa.tlegend      = strrep(scan.glm.plot.contrast,'_',' ');
    fig_axis(sa);
    set(legend,'location','Best');
    fig_figure(gcf());
    fig_fontname();
    fig_fontsize();

end
