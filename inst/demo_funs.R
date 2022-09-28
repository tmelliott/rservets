#' @type x number
#' @type fun "log" | "square" | "inverse"
#' @result number
transform <- function(x, fun) {
    switch(fun, log = log(x), square = x^2, inverse = 1 / x)
}

#' @type x number[]
#' @result { mean: number; stdDev: number }
calculateSummary <- function(x) {
    list(mean = mean(x), stdDev = sd(x))
}

#' @type x number | string | boolean
#' @result string
guessType <- function(x) {
    if (is.numeric(x)) return("number")
    if (is.character(x)) return("string")
    "boolean"
}
