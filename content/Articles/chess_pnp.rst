Chess
=====

:date: 2019-10-12
:modified: 2023-02-16
:tags: print-and-play, piecepack-games
:summary: Some demos of chess-ranked piecepacks as well as the starting diagrams of several chess variants playable with a piecepack.



.. include:: ../../links.rst

This article includes some demos of chess-ranked piecepacks as well as the starting diagrams of several chess variants playable with a piecepack.


.. contents::

Print-and-play chess-ranked piecepacks
--------------------------------------

.. _chess1:

Chess-ranked piecepack
~~~~~~~~~~~~~~~~~~~~~~

The simplest chess-ranked piecepack would be to simply swap in the six chess rank symbols for the six piecepack rank symbols.


.. sourcecode:: r
    

    library("piecepackr")
    noto_credit <- c("\u25cf This piecepack uses characters from Google Noto Fonts. OFL 1.1.",
                     "\thttps://www.google.com/get/noto/")
    
    chess1 <-  list(suit_text = "🌞,🌜,👑,⚜,꩜",
          suit_fontfamily = "Noto Emoji,Noto Sans Symbols2,Noto Emoji,Noto Sans Symbols,Noto Sans Cham",
          suit_cex = "0.6,0.7,0.75,0.9,0.9",
          suit_color = "darkred,black,darkgreen,darkblue,black",
          rank_text = "♟,♞,♝,♜,♛,♚",
          rank_fontfamily = "Noto Sans Symbols")
    chess1$description <- 'This is a chess-ranked piecepack that swaps in the six chess rank symbols for the six piecepack rank symbols.'
    chess1$credit <- c(noto_credit)
    chess1$title <- "Chess-ranked piecepack"
    if (packageVersion("piecepackr") >= "1.10.0-8") {
        chess1$copyright <- "\u00a9 2020 Trevor L Davis.  Some Rights Reserved."
        chess1$spdx_id <- "CC-BY-SA-4.0"
    }
    borders <- list(border_lex=4, border_color="black")
    bleed <- list(border_lex=0, border_color=NA_character_)
    chess1_cutlines <- pp_cfg(chess1)
    chess1_borders <- pp_cfg(c(borders, chess1))
    chess1_bleed <- pp_cfg(c(bleed, chess1))
    grid.piece("preview_layout", cfg=chess1_cutlines)

.. figure:: {static}/images/knitr/demos-chess-preview1-1.png
    :align: center
    :alt: Chess-ranked piecepack
    :width: 60%

    Chess-ranked piecepack

.. _chess2:

French-suited chess-ranked piecepack
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: This custom grob function uses the function ``pp_shape()`` which was introduced in piecepackr_ v1.5.1

If you use a `custom grob function`_ one can easily add checkers to either the tile face or back.  Using the French (playing card) suits may make it easier to play two-player games (like many chess variants).  Since we aren't using the suit symbol as the ace symbol we can move the tile face rank symbol to the lower right for aesthetic reasons without loss of essential piecepack information (can still always tell which is the "special" corner and what are the tile's suit and rank).


.. sourcecode:: r
    

    library("grid")
    checkeredPieceGrob <- function(piece_side, suit, rank, cfg) {
        cfg <- as_pp_cfg(cfg)
        opt <- cfg$get_piece_opt(piece_side, suit, rank)
        shape <- pp_shape(opt$shape, opt$shape_t, opt$shape_r, opt$back)
    
        background_grob <- shape$shape(gp=gpar(col=NA, fill=opt$background_color))
        checkers_grob <- shape$checkers(gp=gpar(fill=opt$gridline_color))
    
        gp_ps <- gpar(col=opt$ps_color, fontsize=opt$ps_fontsize, 
                      fontfamily=opt$ps_fontfamily, fontface=opt$ps_fontface)
        ps_grob <- textGrob(opt$ps_text, x=opt$ps_x, y=opt$ps_y, gp=gp_ps)
    
        gp_dm <- gpar(col=opt$dm_color, fontsize=opt$dm_fontsize, 
                      fontfamily=opt$dm_fontfamily, fontface=opt$ps_fontface)
        dm_grob <- textGrob(opt$dm_text, x=opt$dm_x, y=opt$dm_y, gp=gp_dm)
    
        border_grob <- shape$shape(gp=gpar(col=opt$border_color, fill=NA, lex=opt$border_lex))
    
        gl <- gList(background_grob, checkers_grob, ps_grob, dm_grob, border_grob)
    
        gTree(children=gl, name=piece_side)
    }
    chess2 <- list(suit_color = "darkred,black,dimgrey,hotpink2,grey",
      suit_text = "♥,♠,♣,♦,",
      suit_fontfamily = "Noto Sans Symbols",
      rank_text = "♟,♞,♝,♜,♛,♚",
      rank_fontfamily = "Noto Sans Symbols",
      suit_text.s5 = "꩜",
      suit_fontfamily.s5 = "Noto Sans Cham",
      suit_cex.s5 = 0.9,
      gridline_color.tile_face="grey",
      ps_t.tile_face=-45, ps_r.tile_face=0.3535534, ps_cex.tile_face=0.6,
      grob_fn.tile_face=checkeredPieceGrob)
    chess2$description <- 'This is a French-suited chess-ranked piecepack.'
    chess2$credit <- c(noto_credit)
    chess2$title <- "French-suited chess-ranked piecepack"
    if (packageVersion("piecepackr") >= "1.10.0-8") {
        chess2$copyright <- "\u00a9 2020 Trevor L Davis.  Some Rights Reserved."
        chess2$spdx_id <- "CC-BY-SA-4.0"
    }
    borders <- list(border_lex=4, border_color="black")
    bleed <- list(border_lex=0, border_color=NA_character_)
    chess2_cutlines <- pp_cfg(chess2)
    chess2_borders <- pp_cfg(c(borders, chess2))
    chess2_bleed <- pp_cfg(c(bleed, chess2))
    grid.piece("preview_layout", cfg=chess2_cutlines)

.. figure:: {static}/images/knitr/demos-chess-preview2-1.png
    :align: center
    :alt: French-suited chess-ranked piecepack
    :width: 60%

    French-suited chess-ranked piecepack

Mirrored-color-scheme chess piecepacks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Having two piecepacks with a mirror-color-scheme makes it really easy to play games like Bughouse chess or Reversi/Othello.  Here we'll design one piecepack with six "black" suits and another with six "red" suits.

.. _chess3:

Black-suited mirrored-color-scheme chess-ranked piecepack
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


.. sourcecode:: r
    

    chess3 <- list(suit_text = "♠,♣,🌜,⚓,,,★",
      suit_fontfamily = "Noto Sans Symbols,Noto Sans Symbols,Noto Sans Symbols2,DejaVu Sans,Quivira,Quivira,Noto Sans Symbols",
      suit_cex = "1,1,0.8,0.8,1,1,1",
      suit_color = "black,black,black,black,black,black,darkred",
      grob_fn.tile_back=checkeredPieceGrob,
      suit_text.coin_back = "♟",
      suit_fontfamily.coin_back = "Noto Sans Symbols",
      suit_cex.coin_back = "1",
      dm_text.coin_back = "♠,♣,🌜,⚓,,,★",
      dm_fontfamily.coin_back = "Noto Sans Symbols,Noto Sans Symbols,Noto Sans Symbols2,DejaVu Sans,Quivira,Quivira,Noto Sans Symbols",
      dm_cex.coin_back = "1,1,0.8,1,1,1,1",
      dm_text.coin_face = "★",
      rank_text = "♟,♞,♝,♜,♛,♚", rank_fontfamily="Noto Sans Symbols")
    chess3$description <- 'This is a chess-ranked piecepack with a mirrored-color-scheme.'
    chess3$credit <- c(noto_credit)
    chess3$title <- "Black-suited mirrored-color-scheme chess-ranked piecepack"
    if (packageVersion("piecepackr") >= "1.10.0-8") {
        chess3$copyright <- "\u00a9 2020 Trevor L Davis.  Some Rights Reserved."
        chess3$spdx_id <- "CC-BY-SA-4.0"
    }
    borders <- list(border_lex=4, border_color="black")
    bleed <- list(border_lex=0, border_color=NA_character_)
    chess3_cutlines <- pp_cfg(chess3)
    chess3_borders <- pp_cfg(c(borders, chess3))
    chess3_bleed <- pp_cfg(c(bleed, chess3))
    grid.piece("preview_layout", cfg=chess3_cutlines)

.. figure:: {static}/images/knitr/demos-chess-preview3-1.png
    :align: center
    :alt: Black-suited mirrored-color-scheme chess-ranked piecepack
    :width: 60%

    Black-suited mirrored-color-scheme chess-ranked piecepack

.. _chess4:

Red-suited mirrored-color-scheme chess-ranked piecepack
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


.. sourcecode:: r
    

    chess4 <- chess3
    chess4$suit_text <- "♥,♦,🌞,♚,,,★"
    chess4$suit_fontfamily <- "Noto Sans Symbols,Noto Sans Symbols,Noto Emoji,Noto Sans Symbols,Quivira,Quivira,Noto Sans Symbols"
    chess4$suit_cex <- "1,1,0.8,1,1,1,1"
    chess4$suit_color <- "darkred,darkred,darkred,darkred,darkred,darkred,black"
    chess4$dm_text.coin_back <- "♥,♦,🌞,♚,,,★"
    chess4$dm_fontfamily.coin_back <- "Noto Sans Symbols,Noto Sans Symbols,Noto Emoji,Noto Sans Symbols,Quivira,Quivira,Noto Sans Symbols"
    chess4$dm_cex.coin_back <- "1,1,0.8,1,1,1,1"
    chess4$title <- "Red-suited mirrored-color-scheme chess-ranked piecepack"
    chess4_cutlines <- pp_cfg(chess4)
    chess4_borders <- pp_cfg(c(borders, chess4))
    chess4_bleed <- pp_cfg(c(bleed, chess4))
    grid.piece("preview_layout", cfg=chess4_cutlines)

.. figure:: {static}/images/knitr/demos-chess-preview4-1.png
    :align: center
    :alt: Red-suited mirrored-color-scheme chess-ranked piecepack
    :width: 60%

    Red-suited mirrored-color-scheme chess-ranked piecepack

.. _chess5:

Both-piecepack-and-chess-ranked piecepack
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: This custom grob function uses the function ``pp_shape()`` which was introduced in piecepackr_ v1.5.1

With a `custom grob function`_ and the `right chess font <https://www.chessvariants.com/d.font/utrecht.html>`_ one can make a piecepack that has both the piecepack ranks and the chess ranks.

|
|


.. sourcecode:: r
    

    chessRankGrob <- function(piece_side, suit, rank, cfg=pp_cfg()) {
        cfg <- as_pp_cfg(cfg)
        opt <- cfg$get_piece_opt(piece_side, suit, rank)
        shape <- pp_shape(opt$shape, opt$shape_t, opt$shape_r, opt$back)
    
        # Background
        gp_bg <- gpar(col=NA, lwd=0, fill=opt$background_color)
        if (packageVersion("piecepackr") > '1.13')
            background_grob <- shape$shape(gp=gp_bg, mat_width = opt$mat_width)
        else
            background_grob <- shape$shape(gp=gp_bg)
    
        # Gridlines, Mat
        gp_gl <- gpar(col = opt$gridline_color, lex = opt$gridline_lex)
        if (packageVersion("piecepackr") > '1.13')
            gl_grob <- shape$gridlines(gp = gp_gl, mat_width = opt$mat_width)
        else
            gl_grob <- shape$gridlines(gp = gp_gl)
        mat_grob <- shape$mat(opt$mat_width, gp = gpar(fill = opt$mat_color))
    
        # Primary symbol
        chess_ranks <- c("P", "N", "B", "R", "Q", "K")
        hjusts <- c(0.52, 0.5, 0.48, 0.52, 0.48, 0.52)
        if (piece_side %in% c("tile_face", "coin_face", "coin_back", "die_face")) { 
            gp_ps <- gpar(col="white",
                          fontsize=opt$ps_fontsize, 
                          fontfamily=opt$ps_fontfamily, fontface=opt$ps_fontface)
            ps_grob <- textGrob(opt$ps_text, x=opt$ps_x, y=opt$ps_y, gp=gp_ps)
            fontsize <- list(tile_face=100, coin_back=70, coin_face=70, die_face=45, 
                             matchstick_face=20, pyramid_left=30, pyramid_right=30)
            chess_rank <- ifelse(piece_side == "coin_back", "P", chess_ranks[rank])
            gp_c <- gpar(col=opt$ps_color, fontsize=fontsize[[piece_side]], 
                          fontfamily="Chess Utrecht")
            c_grob <- textGrob(chess_rank, hjust=ifelse(chess_rank=="P", hjusts[1], hjusts[rank]), gp=gp_c)
            ps_grob <- grobTree(c_grob, ps_grob)
        } else {
            gp_ps <- gpar(col=opt$ps_color, fontsize=opt$ps_fontsize, 
                          fontfamily=opt$ps_fontfamily, fontface=opt$ps_fontface)
            ps_grob <- textGrob(opt$ps_text, x=opt$ps_x, y=opt$ps_y, gp=gp_ps)
        }
    
        # Directional mark
        gp_dm <- gpar(col=opt$dm_color, fontsize=opt$dm_fontsize, 
                      fontfamily=opt$dm_fontfamily, fontface=opt$ps_fontface)
        dm_grob <- textGrob(opt$dm_text, x=opt$dm_x, y=opt$dm_y, gp=gp_dm)
    
        # Border 
        border_grob <- shape$shape(gp=gpar(col=opt$border_color, fill=NA, lex=opt$border_lex))
        gl <- gList(background_grob, gl_grob, mat_grob, 
                    ps_grob, dm_grob, border_grob)
    
        gTree(children=gl, name=piece_side)
    }
    piecepack_suits <- list(suit_text="\U0001f31e,\U0001f31c,\U0001f451,\u269c,\uaa5c", # 🌞,🌜,👑,⚜,꩜
                            suit_fontfamily="Noto Emoji,Noto Sans Symbols2,Noto Emoji,Noto Sans Symbols,Noto Sans Cham",
                            suit_cex="0.6,0.7,0.75,0.90,0.9")
    colors <- list(ps_color.s2.tile_face="black", ps_color.s2.coin_back="black", ps_color.s2.die_face="black",
                   invert_colors.pawn=TRUE, 
                   mat_width.tile_back=0.05, mat_color.tile_back="white",
                   invert_colors.matchstick=TRUE, invert_colors.pyramid=TRUE,
                   border_color.matchstick="grey", border_color.s2.pyramid="white")
    orthodox_ranks <- list(rank_text=",\uaa5c,2,3,4,5", use_suit_as_ace=TRUE, 
                           rank_fontfamily="Noto Sans", 
                           rank_fontfamily.r2="Noto Sans Cham", rank_cex.r2.matchstick=0.7)
    misc <- list(grob_fn=chessRankGrob, 
                 dm_text.coin="", dm_text.die="", 
                 ps_cex.tile_face=0.5, ps_cex.r2.tile_face=0.3, ps_cex.s4.r2.tile_face=0.5, 
                 ps_cex.coin=0.9, ps_cex.coin_back=0.3, ps_cex.r2.coin_face=0.7,
                 ps_cex.die_face=0.7, ps_cex.r2.die_face=0.5, ps_cex.s4.r2.die_face=0.6,
                 ps_t.coin=-90, ps_r.coin=0.2, ps_r.coin_back=0.05,
                 ps_t.die=-90, ps_r.die=0.2, ps_t.tile_face=-90, ps_r.tile_face=0.1)
    chess5 <- c(piecepack_suits, orthodox_ranks, misc, colors)
    chess5$description <- 'This is a piecepack that has both the piecepack ranks and the chess ranks.'
    utrecht_credit <- c("\u25cf This piecepack uses characters from the Chess Utrecht font.",
                        "\t\u00a9 1996 by Hans Bodlaender.  Use of the font is free.",
                        "\thttps://www.chessvariants.com/d.font/utrecht.html")
    noto_credit <- c("\u25cf This piecepack uses characters from Google Noto Fonts. OFL 1.1.",
                     "\thttps://www.google.com/get/noto/")
    chess5$credit <- c(utrecht_credit, noto_credit)
    chess5$title <- "Piecepack-and-chess-ranked piecepack"
    if (packageVersion("piecepackr") >= "1.10.0-8") {
        chess5$copyright <- "\u00a9 2020 Trevor L Davis.  Some Rights Reserved."
        chess5$spdx_id <- "CC-BY-SA-4.0"
    }
    borders <- list(edge_color.coin="grey", edge_color.tile="grey",
                    border_lex=4, border_color="black")
    bleed <- list(border_lex=0, border_color=NA_character_)
    chess5_cutlines <- pp_cfg(chess5)
    chess5_borders <- pp_cfg(c(borders, chess5))
    chess5_bleed <- pp_cfg(c(chess5, bleed))
    grid.piece("preview_layout", cfg=chess5_cutlines)

.. figure:: {static}/images/knitr/demos-chess-preview5-1.png
    :align: center
    :alt: A piecepack with both piecepack and chess ranks
    :width: 60%

    A piecepack with both piecepack and chess ranks



Some chess variants playable with a piecepack
---------------------------------------------

Alice Chess
~~~~~~~~~~~

`Alice Chess <{static}/share/rules/alice-chess.pdf>`_ is chess variant invented in 1953 by V.R. Parton played on two boards.


.. sourcecode:: r
    

    library("ppgames")
    pmap_piece(df_alice_chess(), cfg=chess5_borders, op_scale=0.5, 
               trans=op_transform, default.units="in")

.. figure:: {static}/images/knitr/demos-chess-alice-chess-1.png
    :align: center
    :alt: Alice Chess starting diagram
    :width: 60%

    Alice Chess starting diagram

Chaturaji
~~~~~~~~~

`Chaturaji <{static}/share/rules/chaturaji.pdf>`_ (aka Chaturanga for four players aka Choupat) is an old four-person chess variant.


.. sourcecode:: r
    

    pmap_piece(df_chaturaji(), cfg=chess5_borders, op_scale=0.5, 
               trans=op_transform, default.units="in")

.. figure:: {static}/images/knitr/demos-chess-chaturaji-1.png
    :align: center
    :alt: Chaturaji starting diagram
    :width: 60%

    Chaturaji starting diagram

(International) Chess
~~~~~~~~~~~~~~~~~~~~~

`(International) Chess <{static}/share/rules/international_chess.pdf>`_ is a classic board game playable with a single piecepack.


.. sourcecode:: r
    

    pmap_piece(df_international_chess(), cfg=chess5_borders, op_scale=0.5, 
               trans=op_transform, default.units="in")

.. figure:: {static}/images/knitr/demos-chess-international-chess-1.png
    :align: center
    :alt: (FIDE) Chess starting diagram
    :width: 60%

    (FIDE) Chess starting diagram

Four seasons chess
~~~~~~~~~~~~~~~~~~

`Four seasons chess <{static}/share/rules/four-seasons-chess.pdf>`_ is an old 4 player chess variant recorded in the *Acedrex de Los Quatros Tiempos*.


.. sourcecode:: r
    

    pmap_piece(df_four_seasons_chess(), cfg=chess5_borders, op_scale=0.5, 
               trans=op_transform, default.units="in")

.. figure:: {static}/images/knitr/demos-chess-four-seasons-chess-1.png
    :align: center
    :alt: Four seasons chess starting diagram
    :width: 60%

    Four seasons chess starting diagram

Ultima
~~~~~~

`Ultima <{static}/share/rules/ultima.pdf>`_ is chess variant invented by Robert Abbot and published in Recreational Mathematics Magazine in August 1962 under the name Baroque chess.


.. sourcecode:: r
    

    pmap_piece(df_ultima(), cfg=chess5_borders, op_scale=0.5, 
               trans=op_transform, default.units="in")

.. figure:: {static}/images/knitr/demos-chess-ultima-1.png
    :align: center
    :alt: Ultima starting diagram
    :width: 60%

    Ultima starting diagram

Xiangqi (Chinese Chess)
~~~~~~~~~~~~~~~~~~~~~~~

`Xiangqi <{static}/share/rules/xiangqi.pdf>`_ (also called Chinese chess) is a popular board game in Chinese communities and is a member of the chess family of games. 


.. sourcecode:: r
    

    pmap_piece(df_xiangqi(), cfg=chess5_borders, op_scale=0.5, 
               trans=op_transform, default.units="in")

.. figure:: {static}/images/knitr/demos-chess-xiangqi-1.png
    :align: center
    :alt: Xiangqi (Chinese Chess) starting diagram
    :width: 60%

    Xiangqi (Chinese Chess) starting diagram

Some chess variants playable with a piecepack stackpack
-------------------------------------------------------

A piecepack stackpack_ is also handy for playing several chess variants since every player's pieces can then be suited.


.. sourcecode:: r
    

    two_player_scheme <- pp_cfg(list(suit_text="🌞,🌜,👑,⚜,꩜",
             suit_cex="0.6,0.7,0.75,0.9,0.9",
            suit_fontfamily="Noto Emoji,Noto Sans Symbols2,Noto Emoji,Noto Sans Symbols,Noto Sans Cham",
            suit_color="#D55E00,#000000,#F0E442,#0072B2,#009E73",
            background_color="#000000,#D55E00,#0072B2,#F0E442,white",
            border_color="black", border_lex=5, depth.coin = 0.25,
            border_color.tile_back="#009E73", border_lex.tile_back=5
    ))
    two_player_stackpack <- list(piecepack = two_player_scheme,
                                 subpack = to_subpack(two_player_scheme))


Chaturaji
~~~~~~~~~


.. sourcecode:: r
    

    pmap_piece(df_chaturaji(has_subpack = TRUE), envir = two_player_stackpack,
               op_scale = 0.5, trans=op_transform, default.units = "in")

.. figure:: {static}/images/knitr/demos-chess-chaturaji-stackpack-1.png
    :align: center
    :alt: Chaturaji diagram
    :width: 60%

    Chaturaji diagram

(International) Chess
~~~~~~~~~~~~~~~~~~~~~


.. sourcecode:: r
    

    pmap_piece(df_international_chess(has_subpack = TRUE), envir = two_player_stackpack, op_scale=0.5, 
               trans=op_transform, default.units="in")

.. figure:: {static}/images/knitr/demos-chess-international-chess-stackpack-1.png
    :align: center
    :alt: Chess starting diagram
    :width: 60%

    Chess starting diagram

Shogi (Japanese Chess)
~~~~~~~~~~~~~~~~~~~~~~~


.. sourcecode:: r
    

    pmap_piece(df_shogi(has_subpack = TRUE), envir = two_player_stackpack, op_scale=0.5, 
               trans=op_transform, default.units="in")

.. figure:: {static}/images/knitr/demos-chess-shogi-stackpack-1.png
    :align: center
    :alt: Shogi starting diagram
    :width: 60%

    Shogi starting diagram

Xiangqi (Chinese Chess)
~~~~~~~~~~~~~~~~~~~~~~~


.. sourcecode:: r
    

    pmap_piece(df_xiangqi(has_subpack = TRUE), envir = two_player_stackpack, op_scale=0.5, 
               trans=op_transform, default.units="in")

.. figure:: {static}/images/knitr/demos-chess-xiangqi-stackpack-1.png
    :align: center
    :alt: Xiangqi starting diagram
    :width: 60%

    Xiangqi starting diagram




