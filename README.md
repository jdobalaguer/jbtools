
# JBTools



## Paths

Add only the main folder to your path.
» addpath(fileparts(which('jbtools_root.m')));
.. and save your path. Whenever you want to use any of the toolbox, add it all (there are many dependencies) by executing
» jbtools_add
You can remove all folders from the path again with
» jbtools_rm
If you want to update the toolbox (only from UNIX/Linux), simply do
» jbtools_pull



## List of toolboxes

#### anonymous & rebuilt
[anonymous](anonymous) are general functions that I would have liked matlab to include.
[rebuilt](rebuilt) are overloaded functions that matlab already includes.

#### analysis
[analysis](analysis_tool) is a graphical tool for basic data analysis & plotting

#### jb & jbtools
[jb](console) is a single function that aims to enhance some features of the current matlab console (but sacrifices too many good other things)
[jbtools](jb_tools) is a set of functions (similar to anonymous) that are useful for very specific tasks. Having the "jb_" prefix makes them easy to be found!

#### fig
[fig](figures) is a set of functions that help you make nicer figures out of your data

#### matd3
[matd3](matd3) IN CONSTRUCTION. aims for the same as fig, but does it through javascript d3!

#### get_matrix
[get_matrix](getm) is a set of functions that shrink your data (i.e. it takes indexed vectors as an input and returns a matrix). extremely useful for behavioural analyses.

#### model
[model](model) is a framework for model fitting

#### mturk_parse
[mturk](mturk) is a toolbox to import javascript data into matlab. it is very specific to the webserver in our lab. if you don't know what this is for, you probably don't need to use it. 

#### scan
[scan](scan) is a pipeline that runs many kinds of fMRI analyses with minimal effort. it requires SPM8.

#### stats
[stats](stats) IN CONSTRUCTION. is a set of functions useful for statistical analyses. it will hopefully include parametrical, non-parametrical and bayesian approaches (but who knows..)

#### struct
[struct](struct) set of functions useful for manipulation of struct variables

#### web
[web](web) set of functions that allow you to use MATLAB as a web server


## Last stuff

A few functions you'll need to tweak (in case you want to use them):

* jbtools/jb/jb_parallel_start.m : set your parallel toolbox manager
* jbtools/jb/jb_alertmail.m      : set your email and your password

It's also useful to edit your auto-completion settings:
(TODO)

