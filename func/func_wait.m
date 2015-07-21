function file = func_wait(N,file)
    %% file = FUNC_WAIT(N,file)
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
    func_default('N',-1);
    if N < 1 && ~exist('file','var')
        error('func_wait: error. [file] not provided');
    end

    try %#ok<TRYNC>
        % default
        w = 50; % Width of progress bar
        if N > 0
            file = sprintf('.progress_%05i',randi(1e5)-1);
            f = fopen(file, 'w');
            if f<0
                error('Do you have write permissions for %s?', pwd);
            end
            fprintf(f, '%d\n', N); % Save N at the top of progress.txt
            fclose(f);

            fprintf(['  0%%[>', repmat(' ', 1, w), ']\n']);
        elseif N == 0
            if file_exist(file), delete(file); end
            fprintf([repmat(char(8), 1, (w+8)), '100%%[', repmat('=', 1, w+1), ']\n']);
        elseif N == -1
            f = fopen(file, 'a');
            fprintf(f, '1\n');
            fclose(f);

            f = fopen(file, 'r');
            progress = fscanf(f, '%d');
            fclose(f);
            percent = (length(progress)-1)/progress(1)*100;

            perc = sprintf('%3.0f%%%%', percent); % 4 characters wide, percentage
            fprintf([repmat('\b', 1, (w+8)), perc, '[', repmat('=', 1, round(percent*w/100)), '>', repmat(' ', 1, w - round(percent*w/100)), ']\n']);
            drawnow('update');
        end
    end
end
