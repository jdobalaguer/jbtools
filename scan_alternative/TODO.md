
2. in tbte all information about the onset type is lost. this is crucial when using this information for the RSA - find a better way
4. filter RSA, concatenate RSA
5. re-sort RDMs, shrink RDMs
6. handle HDD writing depending on the size of [scan]
9. preprocessing / dicom
A. MVPA
B. TBTE functions
M. see notes in [scan_rsa]
R. in RSA we should recycle the onset information from the TBTE.

LONG TERM
8. scan_merge and scan_from
P. subject masks, mask tools (mni2subject)

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

