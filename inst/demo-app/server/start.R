system("killall Rserve")
Rserve::Rserve(
    args = c(
        "--RS-conf", "rserve.conf",
        "--RS-source", "main.R",
        "--vanilla",
        "--no-save",
        "--silent"
    )
)
