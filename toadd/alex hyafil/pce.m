%%% [ Ymean Yste plothandle]= pce(Y  [,couleur,] [,trait]
%%% [,tailletraitprincipal] [largbar])
%%% trace un graphe avec barres d'erreur assoc�es
%%% Y : - soit tableau de valeurs brutes dont mean et ste dont calcul�es sur
%%% la 1�re dim, 2�me dim : abscisse, 3�me dim : couleur
%%% - soit cell avec mean matrix en premier �lement, ste en deuxi�me :
%%% 1�re dim abscisse, 2�me dim couleur


function [ Ymean Yste plothandle]=pce(Ybrut, cor, trait, taillemean, largbar)

if iscell(Ybrut), %mean et ste d�j� rentr�s,
    Ymean=Ybrut{1};
    Yste=Ybrut{2};
else       % faut calculer
   Ymean=mean(Ybrut,1); 
   Yste=ste(Ybrut);
   Ymean = squeeze(Ymean);
   Yste  = squeeze(Yste);
end
[nbgraph siz]=size(Yste);


if nargin<3, cor= defcolor; end  %bleu par d�faut
if nargin<4, trait='-'; end %trait plein par d�faut
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