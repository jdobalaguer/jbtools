
function fig_fig2subplot(f)

    tf = fig_figure();
    for i = 1:numel(f)
        of = openfig(f{i},'invisible');
        fa = get(of,'Children');
        sp = [size(f),i];
        ta = fig_cloneplot(fa,tf,sp);
        close(of);
    end
end
