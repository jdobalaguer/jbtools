
function scan = scan_mvpa_filename(scan)
    %% scan = SCAN_MVPA_FILENAME(scan)
    % find all beta_1 filenames (image specific) for each subject
    % see also scan_mvpa_run
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    n_image = length(scan.mvpa.image);
    
    betafiles = cell(scan.subject.n,n_image);
    for i_subject = 1:scan.subject.n
        for i_image = 1:n_image
            subject = scan.subject.u(i_subject);
            betafiles{i_subject,i_image} = {};

            p_dire = [scan.dire.glm.beta1,scan.mvpa.image{i_image},'*'];
            p_file = sprintf('beta_sub%02i*_reg*.%s',subject,scan.mvpa.extension);

            u_dire = dir(p_dire);
            n_dire = length(u_dire);
            for i_dire = 1:n_dire
                dire = [scan.dire.glm.beta1,u_dire(i_dire).name,filesep];
                u_file = dir([dire,p_file]);
                n_file = length(u_file);
                for i_file = 1:n_file
                    betafiles{i_subject,i_image}{end+1} = [dire,u_file(i_file).name];
                end
            end
        end
    end
    
    % save
    scan.mvpa.variable.file = betafiles;
    
    
end