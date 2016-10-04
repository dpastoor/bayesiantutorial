bayesian tutorial
=======

This tutorial is a reasonably self-contained tutorial and documentation source about
trasitioning to bayesian analysis from traditional first order estimation techniques
for nonlinear-mixed-effects modeling. The overarching objective is to provide a resource
for some of the additional complexity that bayesian analysis suggests/requires 
(mu-modeling, additional estimation tuning, etc) and to compare output under various scenarios 
to that of FOCE-based estimation.

As a secondary objective, this project should serve as a case study to managing a collaborative
project using git, github and other 'modern' tooling for reproducible science. For
contribution guidelines, see the `CONTRIBUTING` section below.


## Project layout

TODO

## Installation

"package" can be bootstrapped to install all dependencies by installing from github

```
source("https://raw.githubusercontent.com/MangoTheCat/remotes/master/install-github.R")$value("mangothecat/remotes")
remotes::install_github("dpastoor/bayesiantutorial")

```

## Contributing

Contributions must follow the fork-and-branch model of git. Namely, you should
fork this repository, create a separate branch with a descriptive title of what 
that body of work will be, and conduct your changes there.

When ready to propose your changes back to the master repo, rebase your repository,
fix any merge conflicts and merge to master on your fork, then submit a pull request with
the change.

See some articles [here](http://blog.scottlowe.org/2015/01/27/using-fork-branch-git-workflow/) and 
[here](https://gist.github.com/Chaser324/ce0505fbed06b947d962)
