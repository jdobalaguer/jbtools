%%% permet dans un graphe avec plusieurs figures plotcurvemarge de remettre
%%% les figures principales (les moyennes) au premier plan

oldorder=get(gca,'Children');
nbgraf=length(oldorder)/2;
for gragra=1:nbgraf
    nuorder(gragra)=oldorder(2*gragra-1);  %mettre d'abord les figure principales
    nuorder(gragra+nbgraf)=oldorder(2*gragra); %puis les surfaces d'incertitudes
end

set(gca,'Children',nuorder);