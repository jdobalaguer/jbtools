%%% permet de dessiner une courbe avec la marge d'erreur comme fond
%%%%syntaxe plotcurvemarge(X,Ybrut, couleur de la courbe, couleur du fond,
%%%%type de trait, taille du trait)
%%% extrait de Ybrut la moyenne et la std pour chaque point: les 2vecteurs
%%% sont donnés en valeurs de sortie

function [Ymean Ystd]=plotcurvemarge(X, Ymean, Ystd, cor1, cor2, trait, traittaille)

if nargin==6,  %ça veut dire qu'a donné Ybrut, donc fo tout décaler
    Ybrut=Ymean; 
    traittaille=trait;
    trait=cor2;
    cor2=cor1;
    cor1=Ystd;
    Ymean=mean(Ybrut,2)';
Ystd=std(Ybrut,0,2)';
end

l=length(X);
for i=1:l
    X(l+i)=X(l+1-i);  %il faut construire des vecteurs X et Y de taille double qui trace (X,Ym-Ys) d'abord puis (X, Ym+Ys) à l'envers ensuite, pour faire un polygone
    Y(i)=Ymean(i)-Ystd(i);
    Y(l+i)=Ymean(l+1-i)+Ystd(l+1-i);
end
hold on;
fill(X,Y,cor2,'LineStyle','none');
plotcurve(X(1:l),Ymean,cor1,trait,traittaille);