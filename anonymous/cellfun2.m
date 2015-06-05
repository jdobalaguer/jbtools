
function r = cellfun2(varargin)
    %% r = CELLFUN2(f,c1,c2,...)
    % like cellfun, but it returns a cell
    % example: c = cellfun2(@(x,y)x+y,{1,2,3},{1,2,3})
    
    %% function
    
    error('cellfund2: error. don''t use me. call @cellfun with arguments {''UniformOutput'',false} instead');
    r = cellfun(varargin{:},'UniformOutput',false);
    
    % set arguments
%     f = varargin{1};
%     c = varargin(2:end);
%     r = cell(size(c{1}));
%     
%     % assert
%     assertSize(c{:});
%     
%     % cell loop
%     for i = 1:numel(c{1})
%         
%         % get cell values
%         v = cell(1,length(c));
%         for j = 1:length(c)
%             v{j} = c{j}{i};
%         end
%         
%         % local function
%         r{i} = f(v{:});
%     end
    
end