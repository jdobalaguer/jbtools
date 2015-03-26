
function jb_profileend()
    profile('off');
    profsave(profile('info'),'profile_results');
end
