
function X = scan_tool_convolution(scan,i_order,condition)
    %% X = SCAN_TOOL_CONVOLUTION(scan,i_order,condition)
    % convolve a condition in [scan.job.condition] with the basis function in [scan.job.basisFunction]
    % scan      : [scan] struct
    % i_order   : order of interest in the basis function
    % condition : name of the condition
    % X         : resulting signal
    % to list main functions, try
    %   >> help scan;
            
    %% notes
    % this function mimics the convolution performed during the design of the GLM
    % it's based on the normal convolution of SPM, see file
    % "spm_fMRI_design.m" line 203
    
    %% function

    % subject
    X = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % session
        X{i_subject} = cell(1,scan.running.subject.session(i_subject));
        for i_session = 1:scan.running.subject.session(i_subject)
            
            % create basis function
            xBF = struct();
            xBF.UNITS = 'secs';
            xBF.T  = spm_get_defaults('stats.fmri.t');
            xBF.T0 = spm_get_defaults('stats.fmri.t0');
            xBF.name = '';
            xBF.Volterra = 1;
            xBF.dt = scan.parameter.scanner.tr / xBF.T;
            % (this bit is based in "config/spm_run_fmri_spec.m" line 60)
            switch scan.job.basisFunction.name
                case 'hrf'
                    derivs = scan.job.basisFunction.parameters.derivs;
                    if     all(derivs==[0,0]), xBF.name = 'hrf';
                    elseif all(derivs==[1,0]), xBF.name = 'hrf (with time derivative)';
                    elseif all(derivs==[1,1]), xBF.name = 'hrf (with time and dispersion derivatives)';
                    else   scan_tool_error('unknown HRF derivative choices.');
                    end
                case 'fourier',     xBF.name = 'Fourier set';
                                    struct_default(xBF,scan.job.basisFunction.parameters);
                case 'fourier_han', xBF.name = 'Fourier set (Hanning)';
                                    struct_default(xBF,scan.job.basisFunction.parameters);
                case 'gamma',       xBF.name = 'Gamma functions';
                                    struct_default(xBF,scan.job.basisFunction.parameters);
                case 'fir',         xBF.name = 'Finite Impulse Response';
                                    struct_default(xBF,scan.job.basisFunction.parameters);
                otherwise,          scan_tool_error('unknown basis functions.');
            end
            xBF = spm_get_bf(xBF);
            xBF.bf = xBF.bf(:,i_order);
            xBF.order = 1;

            % get inputs, neuronal causes or stimulus functions U
            i_condition = strcmp({scan.running.condition{i_subject}{i_session}.name},condition);
            scan_tool_assert(scan,sum(i_condition)<2,'none or multiple conditions found for subject "%03i" session "%03i" with the same name "%s"',i_subject,i_session,condition);
            
            % no condition matched, skip
            if ~sum(i_condition), continue; end
            
            %(this bit is based in "config/spm_run_fmri_spec.m" line 199)
            U = [];
            U.name = {scan.running.condition{i_subject}{i_session}(i_condition).name};
            U.ons  = scan.running.condition{i_subject}{i_session}(i_condition).onset(:);
            U.dur  = scan.running.condition{i_subject}{i_session}(i_condition).duration(:);
            U.tmod = 0;
            U.pmod = struct('name', {}, 'param', {}, 'poly', {});
            if length(U.dur) == 1, U.dur = repmat(U.dur,size(U.ons)); end
            scan_tool_assert(scan,numel(U.dur) == numel(U.ons),'mismatch between number of onset and number of durations.');
            U.P = struct('name',{'none'},'h',{0});

            % get onsets (this bis is based in "spm_get_ons.m" line 94)
            k = length(scan.running.file.nii.epi3.(scan.job.image){i_subject}{i_session});
            u     = U.ons.^0;
            if ~any(U.dur), u = u/xBF.dt; end
            ton       = round(U.ons/xBF.dt) + 33;
            tof       = round(U.dur/xBF.dt) + ton + 1;
            sf        = sparse((k*xBF.T + 128),size(u,2));
            ton       = max(ton,1);
            tof       = max(tof,1);
            for j = 1:length(ton)
                if size(sf,1) > ton(j), sf(ton(j),:) = sf(ton(j),:) + u(j,:); end %#ok<*SPRIX>
                if size(sf,1) > tof(j), sf(tof(j),:) = sf(tof(j),:) - u(j,:); end
            end
            sf = cumsum(sf);
            sf = sf(1:(k*xBF.T + 32),:);
            U.u  = sf;

            % convolve stimulus functions with basis functions
            X{i_subject}{i_session} = spm_Volterra(U,xBF.bf,1);

            % resample regressors at acquisition times (32 bin offset)
            if ~isempty(X{i_subject}{i_session})
                X{i_subject}{i_session} = X{i_subject}{i_session}((0:(k - 1))*xBF.T + xBF.T0 + 32,:);
            end
        end
    end
end
