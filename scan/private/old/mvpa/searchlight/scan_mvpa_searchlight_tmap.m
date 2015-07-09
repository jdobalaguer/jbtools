
function scan = scan_mvpa_searchlight_tmap(scan)
    %% scan = SCAN_MVPA_SEARCHLIGHT_TMAP(scan)
    % calculate t-statistic of d-maps
    % see also scan_mvpa_dx_searchlight
    % see also scan_mvpa_rsa_searchlight
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    warning('scan_mvpa_searchlight_tmap: warning. assert same mask for all participants');
    
    % template
    template = sprintf('%s/data/nii/sub_%02i/epi3/run1/normalisation%d/*mean*.nii',pwd(),scan.subject.u(1),scan.pars.voxs);
    template = dir(template);
    template = sprintf('%s/data/nii/sub_%02i/epi3/run1/normalisation%d/%s',pwd(),scan.subject.u(1),scan.pars.voxs,template.name);
    
    for i_regressor = 1:length(scan.mvpa.regressor.name)
        
        % load global d-maps
        dmap_crispy = [];
        dmap_smooth = [];
        for i_subject = 1:scan.subject.n
            dmap_crispy(i_subject,:) = scan_nifti_load(sprintf('%ssub_%02i/final/dmap_crispy_%s.img',scan.dire.mvpa.map,scan.subject.u(i_subject),scan.mvpa.regressor.name{i_regressor}));
            dmap_smooth(i_subject,:) = scan_nifti_load(sprintf('%ssub_%02i/final/dmap_smooth_%s.img',scan.dire.mvpa.map,scan.subject.u(i_subject),scan.mvpa.regressor.name{i_regressor}));
        end
        
        % filenames
        path_map = [scan.dire.mvpa.map,'stats/'];
        mkdirp(path_map);
        file_dmap_crispy = sprintf('%sdmap_crispy_%s.img', path_map,scan.mvpa.regressor.name{i_regressor});
        file_dmap_smooth = sprintf('%sdmap_smooth_%s.img', path_map,scan.mvpa.regressor.name{i_regressor});
        file_tmap_crispy = sprintf('%stmap_crispy_%s.img', path_map,scan.mvpa.regressor.name{i_regressor});
        file_tmap_smooth = sprintf('%stmap_smooth_%s.img', path_map,scan.mvpa.regressor.name{i_regressor});
        file_pmap_crispy = sprintf('%spmap_crispy_%s.img', path_map,scan.mvpa.regressor.name{i_regressor});
        file_pmap_smooth = sprintf('%spmap_smooth_%s.img', path_map,scan.mvpa.regressor.name{i_regressor});
        file_hmap_crispy = sprintf('%shmap_crispy_%s.img', path_map,scan.mvpa.regressor.name{i_regressor});
        file_hmap_smooth = sprintf('%shmap_smooth_%s.img', path_map,scan.mvpa.regressor.name{i_regressor});
        
        % save d-maps
        scan.mvpa.variable.result.map.crispy.d_map{i_regressor} = meeze(dmap_crispy,1);
        scan.mvpa.variable.result.map.smooth.d_map{i_regressor} = meeze(dmap_smooth,1);
        
        % statistic maps
        if scan.subject.n > 1
            [h,p,~,stats] = ttest(dmap_crispy,0,'tail','right','alpha',0.001);
            scan.mvpa.variable.result.map.crispy.h_map{i_regressor} = bin2sign(squeeze(h));
            scan.mvpa.variable.result.map.crispy.p_map{i_regressor} = squeeze(p);
            scan.mvpa.variable.result.map.crispy.t_map{i_regressor} = squeeze(stats.tstat);
            [h,p,~,stats] = ttest(dmap_smooth,0,'tail','right','alpha',0.001);
            scan.mvpa.variable.result.map.smooth.h_map{i_regressor} = bin2sign(squeeze(h));
            scan.mvpa.variable.result.map.smooth.p_map{i_regressor} = squeeze(p);
            scan.mvpa.variable.result.map.smooth.t_map{i_regressor} = squeeze(stats.tstat);
        else
            s = size(dmap_crispy);
            s = prod(s(2:end));
            scan.mvpa.variable.result.map.crispy.h_map{i_regressor} = squeeze(zeros(1,s));
            scan.mvpa.variable.result.map.crispy.p_map{i_regressor} = squeeze( ones(1,s));
            scan.mvpa.variable.result.map.crispy.t_map{i_regressor} = squeeze(zeros(1,s));
            scan.mvpa.variable.result.map.smooth.h_map{i_regressor} = squeeze(zeros(1,s));
            scan.mvpa.variable.result.map.smooth.p_map{i_regressor} = squeeze( ones(1,s));
            scan.mvpa.variable.result.map.smooth.t_map{i_regressor} = squeeze(zeros(1,s));
        end
        
        % save maps
        scan_nifti_save(file_dmap_crispy,   scan.mvpa.variable.result.map.crispy.d_map{i_regressor},   template);
        scan_nifti_save(file_tmap_crispy,   scan.mvpa.variable.result.map.crispy.t_map{i_regressor},   template);
        scan_nifti_save(file_pmap_crispy,   scan.mvpa.variable.result.map.crispy.p_map{i_regressor},   template);
        scan_nifti_save(file_hmap_crispy,   scan.mvpa.variable.result.map.crispy.h_map{i_regressor},   template);
        scan_nifti_save(file_dmap_smooth,   scan.mvpa.variable.result.map.smooth.d_map{i_regressor},   template);
        scan_nifti_save(file_tmap_smooth,   scan.mvpa.variable.result.map.smooth.t_map{i_regressor},   template);
        scan_nifti_save(file_pmap_smooth,   scan.mvpa.variable.result.map.smooth.p_map{i_regressor},   template);
        scan_nifti_save(file_hmap_smooth,   scan.mvpa.variable.result.map.smooth.h_map{i_regressor},   template);
    end
    
end
