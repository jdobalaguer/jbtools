%%%% plotcurvemarge(X,Ybrut [,curve colors] [,couleur(s) du(des)
%%%%fond(s)] [,taille du trait] [,type de trait])
%%%permet de dessiner une courbe avec la marge d'erreur comme fond
%%% A la place de Ybrut, on peut mettre directement {Ymean Yste} 
%%% output : mean, ste et plothandle

function [Ymean Yste plothandle]=plotcurvemarge(X, Y, cor1, cor2, traittaille, trait)


if isnumeric(Y) %faut extraire moyenne et ste
    Ymean=mean(Y);
    Yste=ste(Y);
else                %déjà fourni
    Ymean=Y{1};
    Yste=Y{2};
end

[nbgr l]=size(Ymean);

if nargin<6, trait='-'; end
if nargin<5, traittaille=1; end
if nargin<4,  cor2={[.8 .95 .95 ],  [1 .9 .9 ], [.9 1 .9] , [.9 .9 .9]}; end
if nargin<3, cor1={'b'; 'r'; 'g'; 'k'}; end
if ~iscell(cor1), cor1= {cor1}; end
if ~iscell(cor2), cor2 = {cor2}; end

plothandle=[]; 

for gr=1:nbgr   %pour chaque graphe
        
for i=1:l
    X(l+i)=X(l+1-i);  %il faut construire des vecteurs X et Y de taille double qui trace (X,Ym-Ys) d'abord puis (X, Ym+Ys) à l'envers ensuite, pour faire un polygone
    Ypoly(i)=Ymean(gr,i)-Yste(gr,i);
    Ypoly(l+i)=Ymean(gr,l+1-i)+Yste(gr,l+1-i);
end
hold on;
plothandle(2,end+1) = fill(X,Ypoly,cor2{gr},'LineStyle','none');
plothandle(1,end) = plotcurve(X(1:l),Ymean(gr,:),cor1{gr},trait,traittaille);

end

curvemargefront; %%pour remettre les courbes devant