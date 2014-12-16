
function scan = scan_mvpa_image_load(scan)
    %% scan = SCAN_MVPA_IMAGE_LOAD(scan)
    % load matlab file with images
    % see also scan_mvpa_dx
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~isfield(scan.mvpa,'variable') || ~isfield(scan.mvpa.variable,'beta')
        
        % load file with exactly at least those subjects
        filename = sprintf('%simage_%s%s.mat',scan.dire.mvpa.glm,scan.mvpa.image,sprintf('_%d*',scan.subject.u));
        d = dir(filename);
        assert(~isempty(d), 'scan_mvpa_image_load: error. no pre-saved file');
        % choose the smallest one
        dsmall = d(1);
        for i_d = 2:length(d)
            if d(i_d).bytes < dsmall.bytes, dsmall = d(i_d); end
        end
        filename = sprintf('%s%s',scan.dire.mvpa.glm,dsmall.name);
        fprintf('Loading pre-saved file with images. Size is %.2f MB ... \n',dsmall.bytes * 1e-6);
        image = load(filename,'scan');
        scan.mvpa.variable.file = image.scan.mvpa.variable.file;
        scan.mvpa.variable.beta = image.scan.mvpa.variable.beta;
        scan.mvpa.variable.size = image.scan.mvpa.variable.size;
    else
        
        % get the data from scan struct
        % check all subjects are in
        assert(all(ismember(scan.subject.u,scan.mvpa.variable.subject.u)), 'scan_mvpa_image_load: error. not all subjects are available. set scan.mvpa.redo = 1 or remove images first.');
        assert(isfield(scan.mvpa,'glm'),                                   'scan_mvpa_image_load: error. no field scan.mvpa.glm');
        assert(isfield(scan.mvpa.variable,'glm'),                          'scan_mvpa_image_load: error. no field scan.mvpa.variable.glm');
        assert(strcmp(scan.mvpa.glm,scan.mvpa.variable.glm),              ['scan_mvpa_image_load: error. glm doesnt match. set scan.mvpa.glm = "',scan.mvpa.variable.glm,'" or remove images first.']);
        % remove participants not in scan.subject.u
        ii_subject = false(1,scan.mvpa.variable.subject.n);
        for i_subject = 1:scan.subject.n
            ii_subject(scan.mvpa.variable.subject.u == scan.subject.u(i_subject)) = 1;
        end
        scan.mvpa.variable.file(~ii_subject) = [];
        scan.mvpa.variable.beta(~ii_subject) = [];
        scan.mvpa.variable.size(~ii_subject) = [];
        scan.mvpa.variable.subject = scan.subject;
    end
end