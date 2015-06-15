
assertExist('tmp_workspace');
assertStruct(tmp_workspace);
assert(~isfield(tmp_workspace,'tmp_field'), 'jb_workspace_set: error. forbidden field "tmp_field"');
assert(~isfield(tmp_workspace,'tmp_index'), 'jb_workspace_set: error. forbidden field "tmp_index"');

clearvars -except tmp_workspace;

tmp_field = fieldnames(tmp_workspace);
for tmp_index = 1:length(tmp_field)
    eval(sprintf('%s = tmp_workspace.%s;',tmp_field{tmp_index},tmp_field{tmp_index}));
end

clear tmp_workspace tmp_field tmp_index;
