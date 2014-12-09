
function scan = scan_mvpa_image_save(scan)
    %% scan = SCAN_MVPA_IMAGE_SAVE(scan)
    % save matlab file with images
    % see also scan_mvpa_dx
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    save('-v7.3',sprintf('%simage_%s%s.mat',scan.dire.mvpa.glm,scan.mvpa.image,sprintf('_%d',scan.subject.u)),'scan');
    
end