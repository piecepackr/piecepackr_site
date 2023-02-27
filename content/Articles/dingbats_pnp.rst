Dingbats PnP
============

:date: 2019-05-31
:modified: 2023-02-27
:tags: print-and-play
:summary: A demo of emulating of `Daniel Ajoy`_'s Dingbats suited `PiecePack Design Variation`_ using piecepackr_.



.. include:: ../../links.rst

.. _Daniel Ajoy: https://boardgamegeek.com/user/DanielAjoy

.. _PiecePack Design Variation: https://boardgamegeek.com/filepage/91234/piecepack-design-variation

In 2013 `Daniel Ajoy`_ released his `PiecePack Design Variation`_ under a `CC BY 3.0 <http://creativecommons.org/licenses/by/3.0>`_ license.  Besides using Dingbat suit symbols instead of the standard piecepack suits Daniel Ajoy's "Dingbats" piecepack had the following features:

1. Uses a yellow suit instead of a black suit
2. The tile faces of two suits are 'white' and two are 'black'
3. Fronts of the tiles are divided into four sectors
4. The null and ace rank have distinctive symbols

For more info about the design please read `Daniel Ajoy`_'s description and design notes at https://boardgamegeek.com/filepage/91234/piecepack-design-variation.

.. figure:: https://trevorldavis.com/share/piecepack/ajoy_dingbats.jpg
    :align: center
    :width: 80%
    :alt: "Homemade PiecePack" (https://boardgamegeek.com/image/1639074/piecepack) by Daniel Ajoy (https://boardgamegeek.com/user/DanielAjoy) / "CC BY-NC-SA 3.0" (http://creativecommons.org/licenses/by-nc-sa/3.0).

    `Homemade PiecePack <https://boardgamegeek.com/image/1639074/piecepack>`_ by `Daniel Ajoy`_ / `CC BY-NC-SA 3.0`_ 

.. note:: The custom grob function in this article uses the function ``pp_shape()`` which was introduced in piecepackr_ v1.5.1

It is possible to emulate Ajoy's Dingbats piecepack_ in piecepackr_ but in order to emulate his tile faces and null/ace rank symbols we'll need to write and use a custom `grob function`_ in order to add some extra circles/stars on the tile faces and add an extra circle to his null/ace rank symbols.

|

.. _dingbats1:


.. sourcecode:: r
    

    library("grid")
    library("piecepackr")
    ajoyDingbatsGrob <- function(piece_side, suit, rank, cfg=pp_cfg()) {
        cfg <- as_pp_cfg(cfg)
        opt <- cfg$get_piece_opt(piece_side, suit, rank)
        shape <- pp_shape(opt$shape, opt$shape_t, opt$shape_r, opt$back)
    
        # Background
        gp_bg <- gpar(col=NA, fill=opt$background_color)
        if (packageVersion("piecepackr") > '1.13')
            background_grob <- shape$shape(gp=gp_bg, mat_width = opt$mat_width)
        else
            background_grob <- shape$shape(gp=gp_bg)
    
        # Gridlines, Mat
        gl_grob <- shape$gridlines(gp = gpar(col = opt$gridline_color, lex = opt$gridline_lex))
        mat_grob <- shape$mat(opt$mat_width, gp = gpar(fill = opt$mat_color))
    
        if (piece_side == "tile_face") {
            outside_circle_grob <- circleGrob(r=0.25, gp=gpar(col=NA, fill=opt$ps_color))
            col2 <- ifelse(opt$ps_color == "white", "black", "white")
            gp2 <- gpar(col=NA, fill=col2)
            if (rank < 3) {
                inner_circle_grob <- circleGrob(r=0.23, gp=gp2)
            } else {
                inner_circle_grob <- grobTree(pp_shape("concave24", 0, 0.45)$shape(gp=gp2),
                                              vp=viewport(width=0.47, height=0.47))
            }
            circle_grob <- grobTree(outside_circle_grob, inner_circle_grob)
        } else {
            circle_grob <- nullGrob()
        }
    
        # Primary symbol
        gp_ps <- gpar(col=opt$ps_color, fontsize=opt$ps_fontsize, 
                      fontfamily=opt$ps_fontfamily, fontface=opt$ps_fontface)
        ps_grob <- textGrob(opt$ps_text, x=opt$ps_x, y=opt$ps_y, gp=gp_ps)
        if (!is.null(opt$ps_text) && opt$ps_text %in% c("6", "1", "\u0285")) { # "\u03b9", "\u0196", "\u0666", "\u158d"
            gp_c <- gpar(col=opt$ps_color, fontsize=0.95*opt$ps_fontsize, 
                          fontfamily=opt$ps_fontfamily, fontface=opt$ps_fontface)
            c_grob <- textGrob("\u25ef", x=opt$ps_x, y=opt$ps_y, gp=gp_c)
            ps_grob <- grobTree(c_grob, ps_grob)
        }
    
        # Directional mark
        gp_dm <- gpar(col=opt$dm_color, fontsize=opt$dm_fontsize, 
                      fontfamily=opt$dm_fontfamily, fontface=opt$ps_fontface)
        dm_grob <- textGrob(opt$dm_text, x=opt$dm_x, y=opt$dm_y, gp=gp_dm)
    
        # Border 
        border_grob <- shape$shape(gp=gpar(col=opt$border_color, fill=NA, lex=opt$border_lex))
        gl <- gList(background_grob, gl_grob, mat_grob, circle_grob,
                    ps_grob, dm_grob, border_grob)
    
        gTree(children=gl, name=piece_side)
    }
    colors <- list(background_color="#00BFFF,#CD5C5C,#FFD700,#3CB371,white",
                   suit_color="black", 
                   ps_color.s1.tile_face="white", ps_color.s4.tile_face="white",
                   gridline_color.tile_face="black",
                   mat_width.tile=0.05, mat_color.tile="black")
    suits <- list(suit_text="\u2744,\u273d,\u2720,\u27b9,",
                  suit_cex="0.9,0.9,0.8,1.0,1")
    ranks <- list(rank_text="6,\u0285,2,3,4,5", rank_cex="0.6,0.6,0.8,0.8,0.8,0.8")
    misc <- list(dm_text.coin="\u25b2", ps_cex.coin=0.9, fontfamily="Dejavu Sans",
                 grob_fn=ajoyDingbatsGrob)
    dingbats1 <- c(colors, suits, ranks, misc)
    dejavu_credit <- c("\u25cf This piecepack uses characters from the font Dejavu Sans.",
                        "\thttps://dejavu-fonts.github.io/",
                        "\thttps://dejavu-fonts.github.io/License.html")
    ajoy_credit <- c('\u25cf This piecepack emulates Daniel Ajoy\'s "Piecepack Design Variation". CC BY 3.0.',
                     "\thttps://boardgamegeek.com/filepage/91234/piecepack-design-variation",
                     "\thttps://boardgamegeek.com/user/DanielAjoy",
                     "\thttp://creativecommons.org/licenses/by/3.0")
    description <- c('This piecepack emulates Daniel Ajoy\'s "Piecepack Design Variation" aka "Dingbats piecepack" which has the following features:',
                     "\u25cf Uses a yellow suit instead of a black suit",
                     "\u25cf The tile faces of two suits are 'white' and two are 'black'",
                     "\u25cf Fronts of the tiles are divided into four sectors",
                     "\u25cf The null and ace rank have distinctive symbols",
                     "\u25cf For more info see Daniel Ajoy's description and design notes at",
                    "\thttps://boardgamegeek.com/filepage/91234/piecepack-design-variation")
    dingbats1$description <- description
    dingbats1$credit <- c(dejavu_credit, ajoy_credit)
    dingbats1$title <- "Dingbats piecepack (Dingbat suits)"
    if (packageVersion("piecepackr") >= "1.10.0-8") {
        dingbats1$copyright <- "\u00a9 2020 Trevor L Davis.  Some Rights Reserved."
        dingbats1$spdx_id <- "CC-BY-3.0"
    }
    borders <- list(border_lex=4, border_color="black")
    bleed <- list(border_lex=0, border_color=NA_character_)
    dingbats1_cutlines <- pp_cfg(dingbats1)
    dingbats1_borders <- pp_cfg(c(borders, dingbats1))
    dingbats1_bleed <- pp_cfg(c(bleed, dingbats1))
    grid.piece("preview_layout", cfg=dingbats1_cutlines)

.. figure:: {static}/images/knitr/demos-dingbats-preview-1.png
    :align: center
    :alt: A preview of a 'Dingbats' piecepack
    :width: 60%

    A preview of a 'Dingbats' piecepack

.. _dingbats2:

Ajoy's `PiecePack Design Variation`_ PnP file also included a deck using the French suits.  Modifying the above "Dingbats piecepack" `configuration list`_ in order to build this deck is straightforward.


.. sourcecode:: r
    

    dingbats2 <- as.list(dingbats1)
    dingbats2$background_color="#FF5F50,white,#8B795E,#999999,white"
    dingbats2$suit_text="\u2666,\u2665,\u2663,\u2660,"
    dingbats2$suit_cex <- NULL
    dingbats2$suit_color="darkred,darkred,black,black,black"
    dingbats2$dm_color="black"
    dingbats2$dm_color.tile_face=dingbats2$suit_color
    dingbats2$dm_color.die_face=dingbats2$suit_color
    dingbats2$ps_color.die_face="black"
    dingbats2$dm_color.matchstick_face=dingbats2$suit_color
    dingbats2$ps_color.matchstick_face="black"
    dingbats2$ps_color.pyramid_left="black"
    dingbats2$ps_color.pyramid_right="black"
    dingbats2$ps_color.s1.tile_face="black"
    dingbats2$ps_color.s2.tile_face="black"
    dingbats2$ps_color.s3.tile_face="white"
    dingbats2$title <- "Dingbats piecepack (French suits)"
    dingbats2_cutlines <- pp_cfg(dingbats2)
    dingbats2_borders <- pp_cfg(c(borders, dingbats2))
    dingbats2_bleed <- pp_cfg(c(bleed, dingbats2))
    grid.piece("preview_layout", cfg=dingbats2_cutlines)

.. figure:: {static}/images/knitr/demos-dingbats-preview2-1.png
    :align: center
    :alt: A 'Dingbats' style piecepack with French suits
    :width: 60%

    A 'Dingbats' style piecepack with French suits


