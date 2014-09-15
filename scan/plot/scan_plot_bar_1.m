
function scan_plot_bar_1(scan,directory)
    %% SCAN_PLOT_BAR_B1(SCAN,DIRECTORY)
    % Plot bars for BOLD signal (1st level)
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
    values = nan(scan.subject.n , length(scan.glm.plot.contrast));
    for i_contrast = 1:length(scan.glm.plot.contrast)
        dire_contrast = [directory,scan.glm.plot.contrast{i_contrast},filesep()];
        file_subject = dir([dire_contrast,'*_sub*_con*.',scan.glm.plot.extension]);
        file_subject = strcat(dire_contrast,strvcat(file_subject.name));
        value = nan(1,size(file_subject,1));
        for i_subject = 1:size(file_subject,1)
            fil_subject = strtrim(file_subject(i_subject,:));
            nii = spm_vol(fil_subject);
            nii = double(nii.private.dat);
            nii = nii(mask);
            value(i_subject) = nanmean(nii(:));
        end
        values(:,i_contrast) = value;
    end
    m = meeze(values);
    e = steeze(values);
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
