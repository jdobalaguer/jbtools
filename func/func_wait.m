function percent = func_wait(N)
    %% percent = FUNC_WAIT(file,N)
    % prints a fancy waiting bar.
    % it works with the parallel toolbox.
    % multiple scripts can use this function at the same time (improvement from original)
    % example:
    %   func_wait(10); ... initialisation
    %   for i = 1:10, func_wait(); pause(1); end; ... loop
    %   func_wait(0); ... close it at the end
    

    %% based on..
    % percent = progress(N)
    % By Jeremy Scheff - jdscheff@gmail.com - http://www.jeremyscheff.com/

    %% warnings

    %% function
    global progress_file;


    % default
    func_default('N',-1);
    percent = 0;
    w = 50; % Width of progress bar


    if N > 0
        progress_file = sprintf('.progress_%05i',randi(1e5)-1);
        f = fopen(progress_file, 'w');
        if f<0
            error('Do you have write permissions for %s?', pwd);
        end
        fprintf(f, '%d\n', N); % Save N at the top of progress.txt
        fclose(f);

        if nargout == 0
            fprintf(['  0%%[>', repmat(' ', 1, w), ']\n']);
        end
    elseif N == 0
        delete(progress_file);
        percent = 100;

        if nargout == 0
            fprintf([repmat(char(8), 1, (w+8)), '100%%[', repmat('=', 1, w+1), ']\n']);
        end
    else
        if ~exist(progress_file, 'file')
            error('progress file "%s" not found. Run func_wait(N) to initialize it.',progress_file);
        end

        f = fopen(progress_file, 'a');
        fprintf(f, '1\n');
        fclose(f);

        f = fopen(progress_file, 'r');
        progress = fscanf(f, '%d');
        fclose(f);
        percent = (length(progress)-1)/progress(1)*100;

        if nargout == 0
            perc = sprintf('%3.0f%%%%', percent); % 4 characters wide, percentage
            fprintf([repmat('\b', 1, (w+8)), perc, '[', repmat('=', 1, round(percent*w/100)), '>', repmat(' ', 1, w - round(percent*w/100)), ']\n']);
            drawnow('update');
        end
    end
end
