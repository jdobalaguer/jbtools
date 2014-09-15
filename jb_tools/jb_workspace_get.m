
assert(~exist('tmp_workspace','var'),       'jb_workspace_get: error. variable "tmp_workspace" exists');
assert(~exist('tmp_field','var'),           'jb_workspace_get: error. variable "tmp_field" exists');
assert(~exist('tmp_index','var'),           'jb_workspace_get: error. variable "tmp_index" exists');

tmp_field = who();

tmp_workspace = struct();
for tmp_index = 1:length(tmp_field)
    eval(sprintf('tmp_workspace.%s = %s;',tmp_field{tmp_index},tmp_field{tmp_index}));
end

clear tmp_field tmp_index;
