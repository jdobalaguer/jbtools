function plotyyvar(tabx, taby1mean, taby1var, taby2mean, taby2var,  txtx, txty1, txty2, hautbar, largbar, xnames, xmin, xmax, y1min, y1max, y2min, y2max)

[haxes,hline1,hline2] = plotyy(tabx, taby1mean , tabx ,taby2mean);   %plot avec deux ordonn?es
xlabel(txtx);
axes(haxes(1))
if ~isempty(xnames),
set(gca,'XTick', tabx);
set(gca, 'XTickLabel', xnames);  end         %condiname sp?cifi? dans le fichier experience.m
ylabel('Reaction time (s)');

axes(haxes(2))
set(gca,'XTick', tabx);
if ~isempty(xnames),
set(gca, 'XTickLabel', xnames);  end            %condiname sp?cifi? dans le fichier experience.m
ylabel(txty2);
hold on;
for i=1:length(tabx)
barrederreur(tabx(i), taby2mean(i), taby2var(i), hautbar, largbar);
end
hold on;

axes(haxes(1));
if y1min ~= -100,
axis([xmin xmax y1min y1max]); end
for i=1:length(tabx)
barrederreur(tabx(i), taby1mean(i), taby1var(i), hautbar, largbar);
end

axes(haxes(2));
if y2min ~= -100,
axis([xmin xmax y2min y2max]); end
