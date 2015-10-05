
function masked = aux_maskCluster(volume,cor)
    %% masked = AUX_CLUSTERLABELS(obj,volume,cor)
    % mask a volume so that only the pointed cluster is seen
    
    %% notes
    % see http://blogs.mathworks.com/steve/2007/03/20/connected-component-labeling-part-3/
    % see spm_bwlabel
    % see spm_clusters
    
    %% function
    cluster = nan2zero(volume);
    cluster = double(cluster);
    cluster = spm_bwlabel(cluster);
    i_cluster = cluster(cor(1),cor(2),cor(3));
    masked  = volume;
    masked(cluster(:) ~= i_cluster) = nan;
end
