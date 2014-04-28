function [tabmean tabste]=connectsepare(matrix, group1, group2)

%connectsepare(matrix, group1, group2)
%separe la connectivité moyenne entre les différents sousgroupes 


 if nargin==2, group2=group1; end
 
 m1=max(group1);
 m2=max(group2);
 
 [a b]=size(matrix);
 
 group1a = group1'*ones(1,b);   % matrices qui représente le type de chaque item de la matrice
 group2a = ones(a,1)*group2;
 group1vect=reshape(group1a, [1 a*b]);   %on met ça sous un vecteur pour faire passer dans meansepare2
 group2vect=reshape(group2a, [1 a*b]);
 matrixvect= reshape(matrix, [1 a*b]);
 
 [tabmean tabste]=meansepare2(matrixvect, group1vect, group2vect);