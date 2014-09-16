
function scan = scan_plot_design(scan,subject) 
    %% scan = SCAN_PLOT_DESIGN(scan,subject)
    % review the matrix design (of the GLM)
    % see also scan_glm_run
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % SPM
    if ~exist('spm.m','file'), spm8_add_paths(); end

    % load
    file = sprintf('%ssub_%02i/SPM.mat',scan.dire.glm.firstlevel,subject);
    SPM  = load(file);
    SPM  = SPM.SPM;
    
    % report design
    xX      = SPM.xX;
    fnames  = cellstr(SPM.xY.P);
    xs.subject = sprintf('Subject %02i',subject);
    xs = struct2string(scan.glm,xs);
    spm_DesRep('DesMtx',xX,fnames,xs);
    
end

function y = struct2string(x,y)
    f = fieldnames(x);
    for i = 1:length(f)
        o = x.(f{i});
        c = class(o);
        switch c
            case 'string'
                y.(f{i}) = x.(f{i});
            case 'cell'
                y.(f{i}) = '[cell]';
            case 'struct'
                y.(f{i}) = '[struct]';
            otherwise
                y.(f{i}) = num2str(x.(f{i}));
        end
    end
end

