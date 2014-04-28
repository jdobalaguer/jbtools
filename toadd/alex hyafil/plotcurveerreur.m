%%% trace la moyenne de valeurs avec plotcurve en rajoutant l'erreur standard en barres d'erreur (en
%%% faisant apell � la fonction barrederreur.m). Sort en variables de sortie les tableaux des mean et ste.
%%% syntaxe:
%%% [ Ymean Yste plothandle]= = plotcurverreur(X, Y tableau 2d dont sont
%%% extraits mean et ste [,couleur,] [,trait] [,taille du trait principal] 
%%% [,taille du trait barrederreur] [,largeur de la barre(si 0 adapt� � pas de X)])
%%%
%%%ou alors directement plotcurveerreur(X, {Ymean Yste}, cor, trait,...
%%%taillemean, taillestd, largbar)
%%%(en 3�me valeur de retour, renvoie le plot handle de la coube principale
%%%(utile pour metre une l�gende)


function [ Ymean Yste plothandle]=plotcurveerreur(X, Ybrut, cor, trait, taillemean, largbar)

if iscell(Ybrut), %mean et ste d�j� rentr�s,
    Ymean=Ybrut{1};
    Yste=Ybrut{2};
else       % faut calculer
   Ymean=mean(Ybrut,2)'; 
   Yste=ste(Ybrut');
end
[nbgraph siz] = size(Yste);


if nargin<3, cor = defcolor; end  %bleu par d�faut
if nargin<4, trait = '-'; end %trait plein par d�faut
if nargin<5, taillemean = 2; end
if nargin<6, largbar = .3*(X(siz)-X(1))/siz; end

    hold on;
    for gr=1:nbgraph   %pour chaque graphe
    plothandle(1,gr) = plotcurve(X, Ymean(gr,:), cor{gr}, trait, taillemean);
    for kk=1:siz
    plothandle(3*kk-1:3*kk+1,gr) = barrederreur(X(kk),Ymean(gr,kk),Yste(gr,kk), largbar, cor{gr});
    end
    end
    hold off;