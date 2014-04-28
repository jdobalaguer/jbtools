function [Ymean Yste signig plothandles]=plotsepare2(Y,X1, X2, extrait,cores)

if nargin>3,
    if extrait==0,
        extrait=(1:length(X1)); end
    Y=Y(:,extrait);
    X1=X1(:,extrait);
    X2=X2(:,extrait);
end
if nargin<5,
    cores=['b' 'r' 'g' 'k' 'y'];
end
[Ymean Yste]=meansepare2(Y,X1,X2);


if ndims>=2,   % une seule série de donnée, d'où graphe avec les points et les barres d'erreur

plothandles=zeros(1,max(X2));
hold on;
for j=1:max(X2)
ploth=plotcurveerreur(1:max(X1),{Ymean(:,j) Yste(:,j)}, cores{j});
plothandles(j)=ploth(1);
end
%leg=num2str(1:max(X2));
%legend(leg(1:2:2*max(X2)-1));
legend(plothandles, num2str([1:max(X2)]'));

for j=1:max(X2)
    [dem1 dem2 signif]=meansepare(Y,X1,X2==j);
signig(j)=(signif(2));
signi(:,j)=(signig(j)<[.2 .05 .005]);
switch sum(signi(:,j))
    case 1, plotpoint([1 dem1(1)], 'v',10,cores(j),cores(j)); %trendy (p<.2)
    case 2, plotpoint([1 dem1(1)], 'o',10,cores(j),cores(j)); %signif (p<.05)
    case 3, plotpoint([1 dem1(1)], 'h',10,cores(j),cores(j)); %highly signif (p<.005)
end
end


else            %une série de données pour chaque valeur, donc il faut tracer des courbes avec fond pour ste
    [nb1 nb2 nb3]=size(Ymean);
    Ymean2=reshape(Ymean, [nb1*nb2 nb3])';  %on met ça dans un tableau 2d (1ère
    Yste2=reshape(Yste, [nb1*nb2 nb3])';
    cores1=['b' 'r' 'g' 'k'];
    for cc=1:nb2, cores1b(cc,:)=cores1(1:nb1); end
    cores2=['-' ':' ]
    plotcurvemarge([1:nb3], {Ymean2 Yste});
end