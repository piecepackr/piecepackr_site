if (dir.exists("../share") && !dir.exists("../share/rules"))
    dir.create("../share/rules")

set_opts_chunk <- function(prefix="prefix") {
    knitr::opts_chunk$set(out.width="60%", dev='svg', 
                    fig.width=6.05, fig.height=6.05,
                    fig.path=paste0("content/images/knitr/", prefix, "-"),
                    fig.process=function(x) gsub("^content", "{static}", x), 
                    fig.align='center', warning=FALSE)
}

save_rulebook <- function(gk=game_kit(), output_dir=getwd()) {
    tr <- tempfile(fileext=".R")
    on.exit(unlink(tr))
    trdata <- tempfile(fileext=".RData")
    on.exit(unlink(trdata))
    output_dir <- normalizePath(output_dir)
    save(gk, output_dir, file=trdata)
    code <- c("library('ppgames')",
             sprintf("load('%s')", trdata),
             "save_rulebook(gk, output_dir)")
    writeLines(code, tr)
    system2("Rscript", tr)
}

save_ruleset <- function(game, gk=game_kit(), output_dir=getwd()) {
    tr <- tempfile(fileext=".R")
    on.exit(unlink(tr))
    trdata <- tempfile(fileext=".RData")
    on.exit(unlink(trdata))
    output_dir <- normalizePath(output_dir)
    save(game, gk, output_dir, file=trdata)
    code <- c("library('ppgames')",
             sprintf("load('%s')", trdata),
             "save_ruleset(game, gk, output_dir)")
    writeLines(code, tr)
    system2("Rscript", tr)
}

svg2png <- function(svg, png, w=768, h=768) {
    system2("inkscape", c("-z", "-e", png, "-w", w, "-h", h, svg))
}
