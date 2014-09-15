
function scan_plot_peristimulus_2(scan,directory)
    %% SCAN_PLOT_PERISTIMULUS_2(SCAN,DIRECTORY)
    % Plot peristimulus BOLD signal (2nd level)
    % (after running "scan_glm_run" with scan.glm.function = 'fir')
    % see also scan_plot_peristimulus
    
    %% WARNINGS
    %#ok<*NOPRT,*FPARK,*AGROW,*NODEF,*ERTAG>
    
    %% FUNCTION
    fig_figure();
    hold on;
    colours = fig_color('hsv',length(scan.glm.plot.contrast))./255;
    handles = nan(1,length(scan.glm.plot.contrast));
    for i_contrast = 1:length(scan.glm.plot.contrast)
        % assert
        assert(strcmp(scan.glm.function,'fir'),    'scan_plot_peristimulus_2: error. glm function is not "fir"');
        assert(isfield(scan.glm.plot,'mask'),      'scan_plot_peristimulus_2: error. no mask specified');
        file_contrast = dir([directory,'*_',scan.glm.plot.contrast{i_contrast},'*.',scan.glm.plot.extension]);
        file_contrast = strcat(directory,strvcat(file_contrast.name));
        scan.glm.plot.time = linspace(0,scan.glm.fir.len,scan.glm.fir.ord) - scan.glm.delay;
        assert(size(file_contrast,1) == length(scan.glm.plot.time),sprintf('scan_plot_peristimulus_2: error. n_order(%d) and n_time(%d) not consistent',size(file_contrast,1),length(scan.glm.plot.time)));

        % load mask
        scan.file.plot_mask = [scan.dire.mask,scan.glm.plot.mask,'.img'];
        mask = spm_vol(scan.file.plot_mask);
        mask = double(mask.private.dat);
        mask = logical(mask(:));

        % values
        values = nan(1,size(file_contrast,1));
        for i_time = 1:size(file_contrast,1)
            nii = spm_vol(strtrim(file_contrast(i_time,:)));
            nii = double(nii.private.dat);
            nii = nii(mask);
            values(i_time) = nanmean(nii(:));
        end

        % plot
        plot(scan.glm.plot.time,zeros(size(scan.glm.plot.time)),'--k');
        handles(i_contrast) = fig_plot(scan.glm.plot.time,values,'Color',colours(i_contrast,:));
    end
    % figure
    sa.title  = strrep(sprintf('peristimulus time statistics (%s)',scan.glm.plot.mask),'_',' ');
    sa.xlim   = ranger(scan.glm.plot.time) + [-1,+1];
    sa.xtick  = scan.glm.plot.time;
    sa.xticklabel = num2leg(scan.glm.plot.time);
    sa.xlabel = 'time (sec)';
    sa.ilegend      = handles;
    sa.tlegend      = strrep(scan.glm.plot.contrast,'_',' ');
    fig_axis(sa);
    set(legend,'location','Best');
    fig_figure(gcf());
    fig_fontname();
    fig_fontsize();

end
