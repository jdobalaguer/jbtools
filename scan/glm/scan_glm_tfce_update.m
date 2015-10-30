
function scan = scan_glm_tfce_update(scan)
    %% scan = SCAN_GLM_TFCE_UPDATE(scan)
    % update TFCE-toolbox, by Christian Gaser
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % paths
    path_tfce = fullfile(spm('Dir'),'toolbox','TFCE');
    
    % add to path
    addgenpath(path_tfce);

    % update
    scan = tfce_update(scan);
end

%% auxiliar
function scan = tfce_update(scan)
    % based on @cg_tfce_update from the TFCE-toolbox
    r = 0;

    % get current release number
    A = ver;
    for i=1:length(A)
      if strcmp(A(i).Name,'TFCE Toolbox')
        r = str2double(A(i).Version);
      end
    end

    url = 'http://dbm.neuro.uni-jena.de/tfce/';

    % get new release number
    if usejava('jvm')
      [s,sts] = urlread(url);
      if ~sts
        return
      end
    else
      return
    end

    n = regexp(s,'tfce_r(\d.*?)\.zip','tokens');
    if isempty(n)
      return;
    else
      % get largest release number
      rnew = [];
      for i=1:length(n)
        rnew = [rnew str2double(n{i})];
      end
      rnew = max(rnew);
    end

    if rnew > r
        scan_tool_print(scan,false,'Updating the TFCE-toolbox to version %d. Yay!',rnew);
        d = fullfile(spm('Dir'),'toolbox'); 
        try %#ok<TRYNC>
            % list mex-files and delete these files to prevent that old compiled files are used
            mexfiles = dir(fullfile(d,'tfce','*.mex*'));
            for i=1:length(mexfiles)
              name = fullfile(d,'tfce',mexfiles(i).name);
              spm_unlink(name);
            end
            s = unzip([url sprintf('tfce_r%d.zip',rnew)], d);
            rehash
            toolbox_path_cache
            scan = scan_initialize_spm(scan);
        end
    end
end