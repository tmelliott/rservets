test_that('TypeScript definition compiled correctly', {
    t <- tempfile(fileext = ".d.ts")
    on.exit(unlink(t))
    compile_ts(system.file('demo_funs.R', "rservets"), t)
})
