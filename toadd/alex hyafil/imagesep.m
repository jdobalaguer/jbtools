function imagesep(mat, X)
%imagesep(mat, X)

pos = separe(X);    %cell: les positions de chaque ligne, tri�e par cat�gorie
pos = cell2mat(pos);

image(mat(pos,:));