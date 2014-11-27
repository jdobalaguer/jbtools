
function scan = scan_rsa_filename(scan)
    %% scan = SCAN_RSA_FILENAME(scan)
    % find all beta_1 filenames (image specific) for each subject (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    betafiles = {};
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        betafiles{i_subject} = {};
        
        p_dire = [scan.dire.glm.beta1,scan.rsa.image,'*'];
        p_file = sprintf('beta_sub%02i_reg*.%s',subject,scan.rsa.extension);
        
        u_dire = dir(p_dire);
        n_dire = length(u_dire);
        for i_dire = 1:n_dire
            dire = [scan.dire.glm.beta1,u_dire(i_dire).name,filesep];
            u_file = dir([dire,p_file]);
            n_file = length(u_file);
            for i_file = 1:n_file
                betafiles{i_subject}{end+1} = [dire,u_file(i_file).name];
            end
        end
    end
    
    scan.rsa.variable.file = betafiles;
end