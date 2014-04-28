%[Ymean Ystd]=plotsepare(Y,X [,extrait]  [,couleur])
%en utilisant la fonction meansepare, plot un graphe avec valeurs moyennes
%de Y en fonction des valeurs entières prises par X et des barres d'erreurs
%représentant la déviation standard
%pour appliquer une couleur sans extraire, mettre 0 dans le champ extrait
%
%si corrélation signif entre les séries de données, affiche un triangle (p<.2),
%cercle ou hexagramme au premier point

function [Ymean Yste plothandle]=plotsepare(Y,X, varargin)

%def values
extrait = (1:length(X));
cor={'b' 'r' 'g' 'k'};
plottype =''; %à définir plus tard

for v=1:length(varargin)
    var = varargin{v};
    switch class(var)
        case {'double' 'logical'}
            if ~vecteq(var, 0), extrait =var; end
        case 'cell'
            cor = var;
        case 'char'
            plottype = var;
    end
end


    Y=Y(:,extrait);
    X=X(:,extrait);

    
[Ymean Yste signif]=meansepare(Y,X);
[siz1 siz2]=size(Ymean);


hold on;

if siz2==1, Ymean=Ymean'; Yste=Yste'; siz2=siz1; siz1=1; X=[1:siz2]; end

if isempty(plottype),
    if siz1==1 | siz2<7, plottype = 'bar', %%% si un seul jeu de donnée, ou bien plusieurs mais avec pas plus de 6données par jeu, plotte avec barre d'erreur
    else plottype = 'marge';
    end
end


if streq(plottype, 'bar'), 
    [dem1 dem2 plothandle] = plotcurveerreur(1:max(X),{Ymean Yste},cor);
    hold on;
    signi=(signif(1)<[.2 .05 .005]);
    switch sum(signi)
        case 1, plotpoint([1 Ymean(1)], 'v',10); %trendy (p<.2)
        case 2, plotpoint([1 Ymean(1)], 'o',10); %signif (p<.05)
        case 3, plotpoint([1 Ymean(1)], 'h',10); %highly signif (p<.005)
    end
    hold off;
    
else %%sinon, on va plotte ces différents vecteurs avec fond de couleur pour les marges
    
    [dem1 dem2 plothandle] = plotcurvemarge([1:siz1], {Ymean' Yste'}, cor);
end