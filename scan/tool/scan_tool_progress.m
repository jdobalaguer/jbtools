
function scan = scan_tool_progress(scan,progress)
    %% scan = SCAN_TOOL_PROGRESS(scan,progress)
    % progress bar tool
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.parameter.analysis.verbose, return; end
    
    % progress
    if isempty(progress) || ~progress
        func_wait(progress,scan.running.file.progress);
    else
        scan.running.file.progress = func_wait(progress);
    end
    
    % time
    if scan.parameter.analysis.time
        if  progress, tic(); end
        if ~progress,
          t = toc();

          % calculate format time
          l = {'seconds'};
          if                t(1) > 60, t(2) = floor(t(1)/60); t(1) = rem(t(1),60); l{2} = 'minute(s)'; end
          if length(t)>1 && t(2) > 60, t(3) = floor(t(2)/60); t(2) = rem(t(2),60); l{3} = 'hour(s)'; end
          if length(t)>2 && t(3) > 24, t(4) = floor(t(3)/24); t(3) = rem(t(3),24); l{4} = 'day(s)'; end

          % format text
          s = {sprintf('Elapsed time is ')};
          for i = length(t):-1:2
              s{end+1} = sprintf('%d %s ',t(i),l{i}); %#ok<AGROW>
          end
          s{end+1} = sprintf('%.3f %s.\n',t(1),l{1});
          s = strcat(s{:});

          % print
          fprintf(s);
        end
    end
end
