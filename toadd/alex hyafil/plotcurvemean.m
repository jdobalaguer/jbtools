%%% permet de dessiner plusieurs courbes avec en plus
%%%%syntaxe plotcurvemult(X,Ybrut, couleur de la courbe, 
%%%%type de trait, taille du trait)
%%% 

function Ymean=plotcurvemean(X, Ybrut, cor1,  trait, traittaille)

Ymean=mean(Ybrut,2)';

%l=length(X);
%for i=1:l
%    X(l+i)=X(l+1-i);  %il faut construire des vecteurs X et Y de taille double qui trace (X,Ym-Ys) d'abord puis (X, Ym+Ys) ˆ l'envers ensuite, pour faire un polygone
%    Y(i)=Ymean(i)-Ystd(i);
%    Y(l+i)=Ymean(l+1-i)+Ystd(l+1-i);
%end
hold on;
%fill(X,Y,cor2,'LineStyle','none');
plot(X, Ybrut);
plotcurve(X,Ymean,cor1,trait,traittaille);