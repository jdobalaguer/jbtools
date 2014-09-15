
function scan_plot_bar_2(scan,directory)
    %% SCAN_PLOT_BAR_B2(SCAN,DIRECTORY)
    % Plot bars for BOLD signal (2nd level)
    % (after running "scan_glm_run")
    % see also scan_plot_bar
    
    %% WARNINGS
    %#ok<*ERTAG,*FPARK>
    
    %% FUNCTION
    % load mask
    scan.file.plot_mask = [scan.dire.mask,scan.glm.plot.mask,'.img'];
    mask = spm_vol(scan.file.plot_mask);
    mask = double(mask.private.dat);
    mask = logical(mask(:));
    
    % values
    values = nan(1,length(scan.glm.plot.contrast));
    for i_contrast = 1:length(scan.glm.plot.contrast)
        file_contrast = dir([directory,'*_',scan.glm.plot.contrast{i_contrast},'.',scan.glm.plot.extension]);
        file_contrast = [directory,file_contrast.name];
        nii = spm_vol(file_contrast);
        nii = double(nii.private.dat);
        nii = nii(mask);
        values(i_contrast) = nanmean(nii(:));
    end
    
    % plot
    m = values;
    e = zeros(size(values));
    c = fig_color('hsv',length(scan.glm.plot.contrast))./255;
    
    % plot
    f = figure();
    fig_barweb(m,e,...
            [],...                                                  width
            {''},...                                                group names
            '',...                                                  title
            '',...                                                  xlabel
            '',...                                                  ylabel
            c,...                                                   colour
            'y',...                                                 grid
            strrep(scan.glm.plot.contrast,'_',' '),...              legend
            2,...                                                   error sides (1, 2)
            'axis'...                                               legend ('plot','axis')
            );
    fig_axis();
    fig_figure(f);
    fig_fontname(f);
    fig_fontsize(f);
end
