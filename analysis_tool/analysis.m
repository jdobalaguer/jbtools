% 
% ANALYSIS
%
% graphical toolbox for behavioural analysis and plot
% >> analysis();

function a = analysis(varargin)
    delete(get(0,'Children')); % close every figure open
    a = analysis_class(varargin);
end
