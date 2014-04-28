function figh = imagescsep(mat, X, xname, varargin)
%fighandle = imagescsep(mat, X [,xname] [,varargin])

pos = separe(X);    %cell: les positions de chaque ligne, triŽe par catŽgorie
pos2 = cell2mat(pos);

figh = imagesc(mat(pos2,:), varargin{:});

nbel = cellfun(@length, pos);
nbel = [1 nbel(1:end-1)];
set(gca,'YTick', nbel);

if nargin>=3,
    set(gca, 'YTickLabel', xname);
end


%rajouter des lignes horiontales
for el = nbel
    line([0 size(mat,2)], [el el], 'Color', 'k');
end