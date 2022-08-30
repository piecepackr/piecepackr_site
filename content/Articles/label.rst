Labeled piecepack
=================

:status: draft
:date: 2021-03-26



.. include:: ../../links.rst


.. sourcecode:: r
    

    library("piecepackr")
    library("grid")
    labeledTileGrob <- function(piece_side, suit, rank, cfg) {
        cfg <- as_pp_cfg(cfg)
        opt <- cfg$get_piece_opt(piece_side, suit, rank)
        shape <- pp_shape(opt$shape, opt$shape_t, opt$shape_r, opt$back)
    
        background_grob <- shape$shape(gp=gpar(col=NA, fill=opt$background_color))
        gridlines_grob <- shape$gridlines(gp=gpar(col=opt$gridline_color))
        mat_grob <- shape$mat(opt$mat_width, gp = gpar(fill = opt$mat_color))
        rect_grob <- rectGrob(width = 0.15, height = 0.15, gp = gpar(col=NA, fill="white"))
        gp_ps <- gpar(col = opt$ps_color, fontsize = opt$ps_fontsize, 
            fontfamily = opt$ps_fontfamily, fontface = opt$ps_fontface)
        ps_grob <- textGrob(opt$ps_text, x = opt$ps_x, y = opt$ps_y, 
            hjust = 0.5, vjust = 0.5, gp = gp_ps, name = "primary_symbol")
        border_grob <- shape$shape(gp=gpar(col=opt$border_color, fill=NA, lex=opt$border_lex))
        gl <- gList(background_grob, gridlines_grob, mat_grob, rect_grob, ps_grob, border_grob)
        gTree(children=gl, name=piece_side)
    }
    labeled <- as.list(pp_cfg())
    labeled$lacks_rank <- setdiff(labeled$lacks_rank, c("coin_back", "tile_back"))
    labeled$lacks_suit <- setdiff(labeled$lacks_suit, c("coin_face", "tile_back"))
    ranks <- c("n", "a", "2", "3", "4", "5")
    suits <- c("❂", "◐", "♛", "⚜")
    labeled$suit_text <- suits
    labeled$suit_cex.s2 <- 0.9
    labeled$suit_fontfamily <- "DejaVu Sans"
    labeled$suit_color.coin_face <- "#E69F00"
    labeled$grob_fn.tile_back <- labeledTileGrob
    labeled$border_color <- "black"
    labeled$border_lex <- 2
    labeled$dm_cex.coin_face <- 1.2
    labeled$dm_cex.s2.coin_face <- 2.0
    labeled$mat_width.tile_back <- 0.05
    labeled$mat_color.tile_back <- "white"
    labeled$ps_fontsize.tile_back <- 18
    labeled$ps_cex <- 1
    for (r in 1:6) {
        labeled[[paste0("dm_text.r", r, ".coin_back")]] <- ranks[r]
        labeled[[paste0("ps_text.r", r, ".tile_back")]] <- ranks[r]
    }
    for (s in 1:4) {
        labeled[[paste0("dm_text.s", s, ".coin_face")]] <- suits[s]
    }
    labeled <- pp_cfg(labeled)
    grid.piece("preview_layout", cfg=labeled)

.. figure:: {static}/images/knitr/games-label-labeled-piecepack-1.png
    :align: center
    :alt: plot of chunk labeled-piecepack
    :width: 60%

    plot of chunk labeled-piecepack
