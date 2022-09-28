# main launch script - will gradually be reduced down to a
# simple API using rservets package

pkgs <- c("RCurl")

for (pkg in pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cran.rstudio.com")
  }
}

wrap.js.fun <- function(s)
{
  if (class(s) != "javascript_function")
    stop("Can only wrap javascript_function s");
  function(...) {
    Rserve::self.oobMessage(list(s, ...))
  }
}

wrap.r.fun <- Rserve:::ocap

source('funs.R')

give.first.functions <- function()
{
    list(
        transform = wrap.r.fun(transform),
        calulateSummary = wrap.r.fun(calculateSummary),
        guessType = wrap.r.fun(guessType)
    )
}

####################################################################################################
# make.oc turns a function into an object capability accessible from the remote side

# oc.init must return the first capability accessible to the remote side
oc.init <- function()
{
  wrap.r.fun(give.first.functions)
}
