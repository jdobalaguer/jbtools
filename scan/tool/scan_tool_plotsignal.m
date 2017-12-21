
function scan_tool_plotsignal(scan,n_volume,image)
    %% SCAN_TOOL_PLOTSIGNAL(scan,n_volume,image)
    % plot average signal over the whole volume
    % n_volume : if positive, it will plot the first [n_volume] volumes
    %            if negative, it will plot the last [n_volume] volumes
    %            (default +10)
    % image : images to plot (default 'smooth')

    %% parameters

    %% function
    
    % default
    func_default('n_volume',10);
    func_default('image','smooth');
    
    % auto-initialize
    if ~struct_isfield(scan,'running.subject.number')
        scan = scan_initialize(scan);
    end
    
    % autocomplete (nii)
    scan = scan_autocomplete_nii(scan,sprintf('epi3:%s',image));
    
    % print
    scan_tool_print(scan,false,'\nLoading volumes');
    scan = scan_tool_progress(scan,sum(cellfun(@numel,scan.running.subject.session)));
    
    % get signal
    signal = [];
    for i_subject = 1:scan.running.subject.number
        [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
        for i_session = 1:n_session
            files = scan.running.file.nii.epi3.smooth{i_subject}{i_session};

            % filter out
            if     n_volume > 0,  files = files(1:n_volume);
            elseif n_volume < 0,  files = files(end+n_volume+1:end);
            end

            volumes(i_session,:) = nanmean(cell2mat(scan_nifti_load(files)'));
            scan = scan_tool_progress(scan,[]);
        end
        signal(i_subject,:) = nanmean(volumes,1);
    end
    scan = scan_tool_progress(scan,0);
    
    % plot it
    m = nanmean(signal,1);
    e = nanste(signal,1);
    fig_figure();
    fig_combination({'marker','shade','pip','error'},[],m,e);
end
