set_opts_chunk <- function(prefix="prefix") {
    knitr::opts_chunk$set(out.width="60%", dev='svg', 
                    fig.width=6.05, fig.height=6.05,
                    fig.path=paste0("content/images/knitr/", prefix, "-"),
                    fig.process=function(x) gsub("^content", "{static}", x), 
                    fig.align='center', warning=FALSE)
}
