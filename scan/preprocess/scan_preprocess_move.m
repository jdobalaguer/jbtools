
function [scan,job] = scan_preprocess_move(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_MOVE(scan,job)
    % move raw data
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<>

    %% FUNCTION
    for i_subject = scan.subject.u
        nb_runs     = job.run(i_subject);
        u_run       = 1:nb_runs;
        for i_run = u_run
            if nb_runs==1,  dir_from = strcat(sprintf(job.from.path,i_subject),filesep);
                            dir_move = strcat(sprintf(job.move.path,i_subject),filesep);
            else            dir_from = strcat(sprintf(job.from.path,i_subject,i_run),filesep);
                            dir_move = strcat(sprintf(job.move.path,i_subject,i_run),filesep);
            end
            mkdirp(dir_move);
            fprintf('Move folder(s) : subject %02i : run %d \n',i_subject,i_run);
            for i_file = 1:length(job.move.file)
                if ~isempty(dir([dir_from,job.move.file{i_file}])), movefile([dir_from,job.move.file{i_file}],dir_move); end
            end
        end
    end
end
