%img2=flou(img,taille), renvoie une image de plus basse résolution que img,
%ie où on moyenne l'image par carré de taille x taille pixels
function img2=flou(img,taille)

[a b c]=size(img);
img2=zeros(a,b,c);
for cc=1:c
    for aa=1:taille:a
        for bb=1:taille:b
            moy=round(mean(mean( img(aa:min(aa+taille-1,a),bb:min(bb+taille-1,b),cc) ,2)));
            img2(aa:min(aa+taille-1,a),bb:min(bb+taille-1,b),cc) = moy* ones(min(taille,a-aa+1),min(taille,b-bb+1));
        end
    end
end
img2=uint8(img2);