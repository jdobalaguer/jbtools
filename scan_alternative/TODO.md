
6. handle HDD writing depending on the size of [scan]
9. preprocessing
B. TBTE functions
M. see notes in [scan_rsa]
T. warnings in scan_rmdir instead

LONG TERM
8. scan_merge and scan_from
P. subject masks, mask tools (mni2subject)
A. MVPA
V. leave-one-subject-out (LOSO) roi analysis

DONE
1. *fix* the glm FIR function yields different results for equivalent first beta/contrast - and I don't know why
3. find an efficient way of defining models in fake_rsa
E. it's "basis functions", not "function basis"
I. option to ztransf any regressor
J. use SPM function spm_get_defaults
A. ppi (for real)
G. spm_orth is not disabled with "cond.orth = false"
D. is it good that everything works with absolute paths? yeah. why not.
H. when doing PPI, ztransf the regressor (SPM doesnt do it anyway) - you can choose if you want to do it
N. option to add realignment (not in autocomplete)
K. there was a bug, but the "remove_scans" didn't pop-up. check it's working properly.
7. zip/unzip
O. regressors from mat-file
L. move everything to private? nah. at least not for now
Q. template mask library? no. there are multiple voxs possiblities, and all masks are relative to data/mask/
C. plot options parser
9. dicom, expansion
U. constants from concatenation fail if there's no realignment covariates
U. fix concatenation
