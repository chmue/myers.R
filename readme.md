# Myers blended digit preference index for R

This is a straightforward implementation of Myers blended digit preference index in R.

## Usage

The code depends on the `dplyr` package. Please install it, before using the code.

Download [myers-score.R](https://raw.githubusercontent.com/chmue/myers.R/master/myers-score.R)
from this repository and save it to your project's working directory. In R:

```r
library("downloader")
download("https://raw.githubusercontent.com/chmue/myers.R/master/myers-score.R")
```

Then, use it with the following code:

```r
source("myers-score.R")
myers(target_variable, target_frequency, bin_start = 0, bin_size = 40)
```

## Validation

There are currently two unit tests, which compare the output of the function against previous results. If you clone the complete repository, you can run the unit tests with the following snippet. You need the package `testthat`.

```r
source("tests/testthat.R")
```

There is also [a small write-up](doc/validation-lz.md) of the validation using the data from Lee & Zhang 2013 (see below.)

## Acknowledgements

The code is adapted from Stata code by [Germán Rodríguez](http://data.princeton.edu/default.html) available [here](http://data.princeton.edu/eco572/digitpref.html). I also consulted the following research paper for additional guidelines and background on Myers' blended index: Melissa M. Lee and Nan Zhan (2013). The Art of Counting the Governed: Census Accuracy, Civil War, and State Presence. CDDRL Working Papers, Vol. 146. Available [here](http://cddrl.fsi.stanford.edu/publications/the_art_of_counting_the_governed_census_accuracy_civil_war_and_state_presence).

The unit tests use two datasets made available by Germán Rodríguez on the introductory website mentioned above ([phpop1990.dat](http://data.princeton.edu/eco572/datasets/phpop1990.dat) and [bdblci.dat](http://data.princeton.edu/eco572/datasets/bdblci.dat)) and one dataset from Lee & Zhang 1993 (Table OA2.1).

## License

The code is available under the [GNU General Public License 3](https://tldrlegal.com/license/gnu-general-public-license-v3-(gpl-3)) or later.
