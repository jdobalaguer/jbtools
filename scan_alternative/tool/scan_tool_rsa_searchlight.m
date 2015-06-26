
function [r,p,n] = scan_tool_rsa_searchlight(scan,i_subject,i_session)
    %% models = SCAN_TOOL_RSA_SEARCHLIGHT(scan,i_subject,i_session)
    % RSA toolbox - run the searchlight
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % based on searchlightMapping_fMRI.m (the MRC RSA-toolbox)
    
    %% function
    
	% get models
    u_model = nan(length(scan.running.model(1).rdm{i_subject}{i_session}.rdm),numel(scan.job.model));
    for i_model = 1:numel(scan.job.model)
        u_model(:,i_model)   = scan.running.model(i_model).rdm{i_subject}{i_session}.rdm;
    end
	n_model = size(u_model,2);
    
    % get beta
    beta = scan_tool_rsa_fMRIDataPreparation(scan,i_subject,i_session);
    
    % get mask
    mask = scan.running.mask(i_subject);
	mask.valid = false(size(mask.mask));
    mask.valid = mask.mask & all(beta,2) & all(~isnan(beta),2);
    beta = beta(mask.valid,:);

    % build sphere indices
    u_sphere = sphereCentre(scan);

    % get voxel
	u_voxel = find(mask.valid);
	n_voxel = length(u_voxel);

	mask.index = nan(mask.shape);
	mask.index(mask.valid) = 1:n_voxel;

	% results
	n = nan(mask.shape,'single');
	p = nan([mask.shape,n_model],'single');
	r = nan([mask.shape,n_model],'single');

	% searchlight loop
    for i_voxel = 1:n_voxel
        [x,y,z] = ind2sub(mask.shape,u_voxel(i_voxel));
        [p(x,y,z,:),r(x,y,z,:),n(x,y,z,:)] = runSearchlight(scan,x,y,z,u_sphere,mask,beta,u_model);
    end
end

%% auxiliar sphereCentre
function ctrRelSphereSUBs = sphereCentre(scan)
	voxSize_mm          = scan_tool_rsa_voxelsize(scan,scan.running.meta);
	searchlightRad_mm   = scan.job.searchlight;
	rad_vox             = searchlightRad_mm./voxSize_mm;
	minMargin_vox       = floor(rad_vox);
	[x,y,z]             = meshgrid(-minMargin_vox(1):minMargin_vox(1),-minMargin_vox(2):minMargin_vox(2),-minMargin_vox(3):minMargin_vox(3));
	sphere              = ((x*voxSize_mm(1)).^2+(y*voxSize_mm(2)).^2+(z*voxSize_mm(3)).^2)<=(searchlightRad_mm^2);
	sphereSize_vox      = [size(sphere),ones(1,3-ndims(sphere))];
	[sphereSUBx,sphereSUBy,sphereSUBz]=ind2sub(sphereSize_vox,find(sphere));
	sphereSUBs          = [sphereSUBx,sphereSUBy,sphereSUBz];
	ctrSUB              = sphereSize_vox/2+[.5 .5 .5];
	ctrRelSphereSUBs    = sphereSUBs-ones(size(sphereSUBs,1),1)*ctrSUB;
end

%% auxiliar searchlight
function [p,r,n] = runSearchlight(scan,x,y,z,u_sphere,mask,beta,u_model)

    % subindices of voxels
    u_xyz = repmat([x,y,z],[size(u_sphere,1) 1]) + u_sphere;
    r_xyz = (u_xyz(:,1)<1 | u_xyz(:,1)>mask.shape(1) | u_xyz(:,2)<1 | u_xyz(:,2)>mask.shape(2) | u_xyz(:,3)<1 | u_xyz(:,3)>mask.shape(3));
    u_xyz = u_xyz(~r_xyz,:);

    % indices
    ii_voxel = sub2ind(mask.shape,u_xyz(:,1),u_xyz(:,2),u_xyz(:,3));

    % restrict searchlight to voxels inside validDataBrainMask
    f_voxel = mask.index(ii_voxel(mask.valid(ii_voxel)));

    % number of voxels (return if not enough)
    n = length(f_voxel);
    if n < 2, [p,r] = deal(nan(1,size(u_model,2))); return; end

    % build RDM and compare it with models
    rdm = scan_tool_rsa_buildrdm(scan,beta(f_voxel,:)');
    [r,p] = scan_tool_rsa_comparison(scan,rdm,u_model);
end