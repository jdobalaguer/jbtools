% dessine une barre d'erreur avec comme arguments: x, ymean, yvar,
% largeur de barres horizontales, couleur

function u=barrederreur(x, ymean, yvar, largbar, cor)

if iscell(yvar),
    ymoins = yvar{1};
    yplus = yvar{2};
else
    ymoins = yvar;
    yplus = yvar;
end


u1=line([x x],                 [-ymoins  yplus] + ymean, 'LineWidth',1, 'Color', cor);
u2=line([x-largbar x+largbar], ymoins*[-1 -1] + ymean, 'LineWidth',1, 'Color', cor);
u3=line([x-largbar x+largbar], yplus*[ 1  1] + ymean, 'LineWidth',1, 'Color', cor);
u=[u1 u2 u3];