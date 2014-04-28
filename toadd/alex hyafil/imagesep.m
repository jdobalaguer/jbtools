function imagesep(mat, X)
%imagesep(mat, X)

pos = separe(X);    %cell: les positions de chaque ligne, triée par catégorie
pos = cell2mat(pos);

image(mat(pos,:));