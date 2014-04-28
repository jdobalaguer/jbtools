function ploth = graf(xvect, yvect, colazvect, opt)
%ploth = graf(xvect, yvect, colazvect, colaz)
%ou %ploth = graf(xvect, yvect, colazvect, 'param'/'normalize')


if nargin<4, opt = defcolor; end
ploth=[];
hold on;

if isstr(opt)
    if streq(opt, 'normalize'), colazvect = (colazvect - min(colazvect))/(max(colazvect) - min(colazvect)); end
    
map = colormap;
colazvect = ceil(size(map,1)*colazvect);
colazvect(colazvect==0)=1;

    for i=1:length(colazvect)
       plothh = plot( xvect(i), yvect(i), 'Color',  map(colazvect(i),:), 'Marker', '.', 'LineStyle', 'none');
    end

else
    
for c=1:max(colazvect)
    plothh = plot( xvect(colazvect==c), yvect(colazvect==c), 'Color', opt{c}, 'Marker', '.', 'LineStyle', 'none');
    ploth = [ploth plothh];    
end
    
end