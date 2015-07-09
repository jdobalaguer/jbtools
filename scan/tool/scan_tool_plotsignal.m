
function scan_tool_plotsignal(scan,n_volume)
    %% PLOT_SIGNAL
    % plot average signal over the whole volume

    %% parameters

    %% function
    
    % auto-initialize
    if ~struct_isfield(scan,'running.subject.number')
        scan = scan_initialize(scan);
    end
    
    % autocomplete (nii)
    scan = scan_autocomplete_nii(scan,'epi3:smooth');
    
    % get signal
    signal = [];
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            files = scan.running.file.nii.epi3.smooth{i_subject}{i_session};

            % filter out
            if     n_volume > 0,  files = files(1:n_volume);
            elseif n_volume < 0,  files = files(end+n_volume+1,end);
            end

            volumes(i_session,:) = nanmean(cell2mat(scan_nifti_load(files)'));
        end
        signal(i_subject,:) = nanmean(volumes,1);
    end
    
    % plot it
    m = nanmean(signal,1);
    e = nanste(signal,1);
    fig_figure();
    fig_combination({'marker','shade','pip','error'},[],m,e);
end
