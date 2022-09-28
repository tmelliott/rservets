#' Generate 'typesafe' OCAPs
#'
#' @param file a file containing typed function(s) (i.e., with `@type` and `@result` coments)
#' @return an Rserve function with type assertion
#' @importFrom Rserve
#' @export
ocaps <- function(file) {
    funs <- lapply(roxygen2::parse_file(file),
        function(result) {
            fun <- roxygen2::block_get_tag(result, "result")$val$rcheck
            print(fun)
            function(...) {
                x <- eval(result$call)(...)
                fun(x)
            }
        }
    )
    funs
}
