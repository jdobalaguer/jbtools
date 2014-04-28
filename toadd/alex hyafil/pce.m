%%% [ Ymean Yste plothandle]= pce(Y  [,couleur,] [,trait]
%%% [,tailletraitprincipal] [largbar])
%%% trace un graphe avec barres d'erreur assocées
%%% Y : - soit tableau de valeurs brutes dont mean et ste dont calculées sur
%%% la 1ère dim, 2éme dim : abscisse, 3ème dim : couleur
%%% - soit cell avec mean matrix en premier élement, ste en deuxième :
%%% 1ère dim abscisse, 2ème dim couleur


function [ Ymean Yste plothandle]=pce(Ybrut, cor, trait, taillemean, largbar)

if iscell(Ybrut), %mean et ste déjà rentrés,
    Ymean=Ybrut{1};
    Yste=Ybrut{2};
else       % faut calculer
   Ymean=mean(Ybrut,1); 
   Yste=ste(Ybrut);
   Ymean = squeeze(Ymean);
   Yste  = squeeze(Yste);
end
[nbgraph siz]=size(Yste);


if nargin<3, cor= defcolor; end  %bleu par défaut
if nargin<4, trait='-'; end %trait plein par défaut
if nargin<5, taillemean=2; end
if nargin<6, largbar=.3; end

    hold on;
    for gr=1:nbgraph   %pour chaque graphe
    plothandle(1,gr) = pc( Ymean(gr,:), cor{gr}, trait, taillemean);
    for kk=1:siz
    plothandle(3*kk-1:3*kk+1,gr) = barrederreur(kk,Ymean(gr,kk),Yste(gr,kk), largbar, cor{gr});
    end
    end
    hold off;