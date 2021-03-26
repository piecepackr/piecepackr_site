if (dir.exists("../share") && !dir.exists("../share/rules"))
    dir.create("../share/rules")

set_opts_chunk <- function(prefix="prefix") {
    knitr::opts_chunk$set(out.width="60%", dev="svg",
                    fig.width=6.05, fig.height=6.05,
                    fig.path=paste0("content/images/knitr/", prefix, "-"),
                    fig.process=function(x) gsub("^content", "{static}", x),
                    fig.align="center", warning=FALSE)
}

create_pnp <- function(Rdata_file) {
    if (!file.exists("../share/pnp")) dir.create("../share/pnp")
    ee <- new.env()
    load(Rdata_file, envir=ee)
    nn <- sort(names(ee))
    for (name in nn) {
        cfg <- ee[[name]]
        piecepackr::save_print_and_play(cfg, sprintf("../share/pnp/%s_letter.pdf", name), "letter")
        piecepackr::save_print_and_play(cfg, sprintf("../share/pnp/%s_A4.pdf", name), "A4")
    }
    invisible(NULL)
}

save_rulebook <- function(book, gk=game_kit(), output=NULL) {
    tr <- tempfile(fileext=".R")
    on.exit(unlink(tr))
    trdata <- tempfile(fileext=".RData")
    on.exit(unlink(trdata))
    save(book, gk, output, file=trdata)
    code <- c("library('ppgames')",
              sprintf("load('%s')", trdata),
              "save_rulebook(book, gk=gk, output=output)")
    writeLines(code, tr)
    system2("Rscript", tr)
}

save_ruleset <- function(game, gk=game_kit(), output=NULL, size="letter") {
    tr <- tempfile(fileext=".R")
    on.exit(unlink(tr))
    trdata <- tempfile(fileext=".RData")
    on.exit(unlink(trdata))
    save(game, gk, output, size, file=trdata)
    code <- c("library('ppgames')",
              sprintf("load('%s')", trdata),
              "save_ruleset(game, gk, output, size=size)")
    writeLines(code, tr)
    system2("Rscript", tr)
}

save_pamphlet <- function(game, gk=game_kit(), output=NULL, size="letter") {
    tr <- tempfile(fileext=".R")
    on.exit(unlink(tr))
    trdata <- tempfile(fileext=".RData")
    on.exit(unlink(trdata))
    save(game, gk, output, size, file=trdata)
    code <- c("library('ppgames')",
              sprintf("load('%s')", trdata),
              "save_pamphlet(game, gk, output, size=size)")
    writeLines(code, tr)
    system2("Rscript", tr)
}

svg2png <- function(svg, png, w=768, h=768) {
    # system2("inkscape", c("-z", "-e", png, "-w", w, "-h", h, svg)) # nolint
    rsvg::rsvg_png(svg, png, w, h)
}
rst_list_table <- function(df, title=NULL, widths=NULL) {
    df <- as.data.frame(df)
    nc <- ncol(df)
    cat(".. list-table::", title, "\n")
    cat("\t:header-rows:", 1, "\n")
    if(!is.null(widths))
        cat("\t:widths:", widths, "\n")
    cat("\n")
    col_names <- names(df)
    cat("\t* -", col_names[1], "\n")
    for (ic in 2:nc) { cat("\t  -", col_names[ic], "\n") }
    for(ir in 1:nrow(df)) {
        cat("\t* -", df[ir, 1], "\n")
        for(ic in 2:nc) { cat("\t  -", df[ir, ic], "\n") }
    }
    cat("\n")
}
