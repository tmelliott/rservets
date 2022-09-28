#' Compile TypeScript definitions
#'
#' @section Types
#' Here is a table of R types and their corresponding TS type
#'
#'
#' @param file the file containing marked-up R functions
#' @param output the location to save ts type files
#' @return null, called for sideeffect of writing a file
#' @importFrom roxygen2 roxy_tag_parse roclet_process roclet_output
#' @export
compile_ts <- function(file, output = sprintf('%s.d.ts', tools::file_path_sans_ext(file))) {
    results <- roxygen2::roc_proc_text(types_roclet(), readLines(file))
    defns <- roxygen2::roclet_output(types_roclet(), results)
    writeLines(defns, con = output)
    invisible(NULL)
}

#' @export
roxy_tag_parse.roxy_tag_type <- function(x) {
    parsed <- stringi::stri_match(str = x$raw, regex = "([a-zA-Z]+)\ (.+)")[1,]
    x$val <- list(
        variable = parsed[[2]],
        type = parsed[[3]]
    )
    x
}

#' @export
roxy_tag_parse.roxy_tag_result <- function(x) {
    x$val <- x$raw
    x
}

types_roclet <- function() {
    roxygen2::roclet("types")
}

#' @export
roclet_process.roclet_types <- function(x, blocks, env, base_path) {
    results <- lapply(blocks, function(block) {
        inputs <- roxygen2::block_get_tags(block, "type")
        result <- roxygen2::block_get_tag(block, "result")
        list(name = block$object$topic, inputs = inputs, result = result)
    })
    results
}

#' @export
roclet_output.roclet_types <- function(x, results, base_path, ...) {
    sapply(results, function(result) {
        sprintf("export function %s(%s): %s;",
            result$name,
            paste(
                sapply(result$inputs,
                    function(input)
                        sprintf("%s: %s", input$val$variable, input$val$type)
                ),
                collapse = ", "
            ),
            result$result$val
        )
    })
}
