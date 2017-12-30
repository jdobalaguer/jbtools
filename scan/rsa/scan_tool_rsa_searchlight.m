
function [r,p,n,rdm] = scan_tool_rsa_searchlight(scan,i_subject,i_session,rdm)
    %% models = SCAN_TOOL_RSA_SEARCHLIGHT(scan,i_subject,i_session,rdm)
    % RSA toolbox - run the searchlight
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % based on searchlightMapping_fMRI.m (the MRC RSA-toolbox)
    
    %% function
    
	% get models
    u_model = nan(length(scan.running.model(1).rdm{i_subject}{i_session}.rdm),numel(scan.job.model));
    u_filter = false(size(u_model));
    for i_model = 1:numel(scan.job.model)
        u_model(:,i_model)  = scan.running.model(i_model).rdm{i_subject}{i_session}.rdm;
        u_filter(:,i_model) = scan.running.model(i_model).rdm{i_subject}{i_session}.filter;
    end
	n_model = size(u_model,2);
    
    % get beta
    beta = scan_tool_rsa_fMRIDataPreparation(scan,scan.running.subject.unique(i_subject),scan.running.subject.session{i_subject}(i_session));
    
    % get mask
    mask = scan.running.mask(i_subject);
    mask.valid = logical(mask.mask);
    beta = beta(mask.valid,:);
    
    % mask the relevant RDM subject/session
    if ~isempty(scan.job.loadRDM)
        rdm = rdm(:,mask.valid);
    end

    % build sphere indices
    u_sphere = sphereCentre(scan);

    % get voxel
	u_voxel = find(mask.valid);
	n_voxel = length(u_voxel);

	mask.index = nan(mask.shape);
	mask.index(mask.valid) = 1:n_voxel;

    % whitening
    R = getResiduals(scan,i_subject,mask);
    
	% results
	n = nan(mask.shape,'single');
	p = nan([mask.shape,n_model],'single');
	r = nan([mask.shape,n_model],'single');

	% searchlight loop (don't save RDMs)
    if ~scan.job.saveRDM
        for i_voxel = 1:n_voxel
            [x,y,z] = ind2sub(mask.shape,u_voxel(i_voxel));
            [p(x,y,z,:),r(x,y,z,:),n(x,y,z,:)] = runSearchlight(scan,x,y,z,u_sphere,mask,beta,u_model,u_filter,R,i_subject,i_session,rdm);
        end
	% searchlight loop (save RDMs)
    else
        n_condition = size(beta,2);
        s_rdm       = 0.5 * n_condition * (n_condition - 1);
        if isempty(rdm), rdm = nan([s_rdm,mask.shape],'single'); end
        for i_voxel = 1:n_voxel
            [x,y,z] = ind2sub(mask.shape,u_voxel(i_voxel));
            [p(x,y,z,:),r(x,y,z,:),n(x,y,z,:),t_rdm] = runSearchlight(scan,x,y,z,u_sphere,mask,beta,u_model,u_filter,R,i_subject,i_session,rdm);
            if ~isempty(t_rdm), rdm(:,u_voxel(i_voxel)) = t_rdm; end
        end
    end
end

%% auxiliar: sphereCentre
function ctrRelSphereSUBs = sphereCentre(scan)
	voxSize_mm          = scan_tool_voxelsize(scan,scan.running.meta);
	searchlightRad_mm   = scan.job.searchlight;
	rad_vox             = searchlightRad_mm./voxSize_mm;
	minMargin_vox       = floor(rad_vox);
	[x,y,z]             = meshgrid(-minMargin_vox(1):minMargin_vox(1),-minMargin_vox(2):minMargin_vox(2),-minMargin_vox(3):minMargin_vox(3));
	sphere              = ((x*voxSize_mm(1)).^2+(y*voxSize_mm(2)).^2+(z*voxSize_mm(3)).^2)<=(searchlightRad_mm^2);
	sphereSize_vox      = [size(sphere),ones(1,3-ndims(sphere))];
	[sphereSUBx,sphereSUBy,sphereSUBz]=ind2sub(sphereSize_vox,find(sphere));
	sphereSUBs          = [sphereSUBx,sphereSUBy,sphereSUBz];
	ctrSUB              = 0.5*sphereSize_vox + [.5 .5 .5];
	ctrRelSphereSUBs    = sphereSUBs-ones(size(sphereSUBs,1),1)*ctrSUB;
end

%% auxiliar: getResiduals
function R = getResiduals(scan,i_subject,mask)
    R = {};
    if ~scan.job.whitening, return; end
    R = scan_nifti_load(scan.running.glm.running.file.residual.volumes{i_subject},mask.valid);
    R = cat(2,R{:})';
    R = single(R);
    u_session = unique(scan.running.glm.running.subject.session{i_subject});
    R = mat2cell(R,arrayfun(@(s)sum(scan.running.glm.running.design(i_subject).row.session==s),u_session),size(R,2));
end

%% auxiliar: searchlight
function [p,r,n,rdm] = runSearchlight(scan,x,y,z,u_sphere,mask,beta,u_model,u_filter,R,i_subject,i_session,rdm)

    % pre-computed RDM
    if isempty(scan.job.loadRDM)
        % subindices of voxels
        u_xyz = repmat([x,y,z],[size(u_sphere,1) 1]) + u_sphere;
        r_xyz = (u_xyz(:,1)<1 | u_xyz(:,1)>mask.shape(1) | u_xyz(:,2)<1 | u_xyz(:,2)>mask.shape(2) | u_xyz(:,3)<1 | u_xyz(:,3)>mask.shape(3));
        u_xyz = u_xyz(~r_xyz,:);

        % indices
        ii_voxel = sub2ind(mask.shape,u_xyz(:,1),u_xyz(:,2),u_xyz(:,3));

        % restrict searchlight to voxels inside mask.valid
        f_voxel = mask.index(ii_voxel(mask.valid(ii_voxel)));

        % number of voxels (return if not enough)
        n = length(f_voxel);
        if n < 2, [p,r] = deal(nan(1,size(u_model,2))); rdm = []; return; end

        % select voxels
        beta = beta(f_voxel,:)';

        % whitening
        if scan.job.whitening
            R = cellfun(@(r)r(:,f_voxel),R,'UniformOutput',false);
            beta = scan_tool_rsa_whitening(scan,beta,R,i_subject,i_session);
        end

        % build RDM and compare it with models
        beta = scan_tool_rsa_transformation(scan,beta);
        rdm  = scan_tool_rsa_buildrdm(scan,beta,i_subject,i_session);
    else
        u_voxel = find(mask.valid);
        i_voxel = (u_voxel == sub2ind(mask.shape,x,y,z));
        rdm = rdm(:,i_voxel)';
        n = nan;
    end
    [r,p] = scan_tool_rsa_comparison(scan,rdm,u_model,u_filter);
    
    % only send back the RDM if necessary
    if ~scan.job.saveRDM, rdm = []; end
end