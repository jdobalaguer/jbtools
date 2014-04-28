function [Ym Yste]=plotsepareblock(Y,X,n,extrait)

if nargin==3, extrait=[1:length(X)]; end

[Ym Yste]=meansepareblock(Y,X,n, extrait);
[dem l]=size(Ym);

plotcurvemarge(n*[1:l], {Ym, Yste}); 

