
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rservets

<!-- badges: start -->

<!-- badges: end -->

The **rservets** package provides methods and workflows for developing
[**Rserve**](github.com/att/Rserve) methods that are typesafe for use in
Javascript apps compiled with TypeScript. This is primarily targeted at
libraries like ReactJS, but should be flexible for use elswhere.

There are two steps:

1.  compilation of TypeScript definition files (`module.d.ts`) in a TS
    app dir
2.  (automatic) wrapping of methods to assert a valid return type (and
    error otherwise)

This should allow R and JS developers to work together more easily to
create advanced web-apps powered by R.

## Installation

You can install the development version of rservets like so:

``` r
remotes::install_github('tmelliott/rservets')
```

## Example

Here are some demo functions in the packages `inst/demo` directory:

**main.R**

``` r
#' @type x number
#' @type fun "log" | "square" | "inverse"
#' @result number
transform <- function(x, fun) {
    switch(fun, log = log(x), square = x^2, inverse = 1 / x)
}

#' @type x number[]
#' @result { mean: number, stdDev: number }
calculateSummary <- function(x) {
    list(mean = mean(x), stdDev = sd(x))
}
```

We can compile these functions into typescript definitions:

``` r
library(rservets)
compile_ts(
  system.file('demo/main.R', package = "rservets"),
  output = "main.d.ts"
)
```

**main.d.ts**

``` ts
export function transform(x: number, fun: "log" | "square" | "inverse"): number;
export function calculateSummary(x: number[]): { mean: number, stdDev: number };
```
