Custom grob functions
=====================

:date: 2019-04-23
:modified: 2020-08-22
:tags: piecepackr-features
:summary: Although using piecepackr_'s `configuration lists`_ provide a powerful high-level way to alter the appearance of your piecepack_ graphics piecepackr_ also allows one to modify the appearance of your piecepack graphics even more with the use of custom grob functions.  



.. include:: ../../links.rst

.. contents::

Intro
-----

.. note:: The custom grob functions in this article use the function ``pp_shape()`` which was introduced in piecepackr_ v1.5.1

Although using piecepackr_'s `configuration lists`_ provide a powerful high-level way to alter the appearance of your piecepack_ graphics piecepackr_ also allows one to modify the appearance of your piecepack graphics even more with the use of custom grob functions.  

Examples
--------

Checkered Tile Backs
~~~~~~~~~~~~~~~~~~~~

.. warning:: Some people (including the inventor James "Kyle" Droscha) feel that `adding checkers to the back of one's piecepack is a bad idea <http://www.ludism.org/ppwiki/DesignFAQ>`_, in particular they leak information about the direction of the tile face.

The default grob function doesn't support adding checkers to the back of your piecepack tiles but piecepackr_ does include a utility function ``checkersGrob`` that can be used via a custom grob function:

|
|
|


.. sourcecode:: r
    

    library("grid")
    library("piecepackr")
    
    checkeredPieceGrob <- function(piece_side, suit, rank, cfg) {
        cfg <- as_pp_cfg(cfg)
        opt <- cfg$get_piece_opt(piece_side, suit, rank)
        shape <- pp_shape(opt$shape, opt$shape_t, opt$shape_r, opt$back)
    
        background_grob <- shape$shape(gp=gpar(col=NA, fill=opt$background_color))
        checkers_grob <- shape$checkers(gp=gpar(fill=opt$gridline_color))
        border_grob <- shape$shape(gp=gpar(col=opt$border_color, fill=NA, lex=opt$border_lex))
        gl <- gList(background_grob, checkers_grob, border_grob)
        gTree(children=gl, name=piece_side)
    }
    cfg <- list(grob_fn.tile_back=checkeredPieceGrob)
    grid.piece("preview_layout", cfg=cfg)

.. figure:: {static}/images/knitr/docs-custom_grob_fn-checker_back-1.png
    :align: center
    :alt: Custom grob function to use checkers on the tile back
    :width: 60%

    Custom grob function to use checkers on the tile back

The above custom grob function was written fairly generally so it can also support ``convex#`` polygons (i.e. "Hexpack" tiles):


.. sourcecode:: r
    

    cfg <- list(grob_fn.tile_back=checkeredPieceGrob, shape.tile="convex6", 
                shape.coin="convex3", shape.saucer="convex3")
    grid.piece("preview_layout", cfg=cfg)

.. figure:: {static}/images/knitr/docs-custom_grob_fn-hexpack_checker_back-1.png
    :align: center
    :alt: 'checkersGrob' even works on hexagon shaped tiles
    :width: 60%

    'checkersGrob' even works on hexagon shaped tiles

Pawn Belts with Three Suit Symbols
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The pawn belts in Jonathan Dietrich's `JCD piecepack`_ and Chris Sakkas' `Nine-Suit Piecepack <http://fossilbank.wikidot.com/local--files/entry:piecepack/NINEPIECEPACK.svg>`_ both feature three suit symbols but it is difficult to replicate such a belt with piecepackr_'s default draw function since it only supports one primary symbol and one directional mark [*]_.


.. sourcecode:: r
    

    pawnBeltGrob <- function(piece_side, suit, rank, cfg) {
        cfg <- as_pp_cfg(cfg)
        opt <- cfg$get_piece_opt(piece_side, suit, rank)
        shape <- pp_shape(opt$shape, opt$shape_t, opt$shape_r, opt$back)
    
        background_grob <- shape$shape(gp=gpar(col=NA, fill=opt$background_color))
        center_grob <- rectGrob(width=0.3, gp=gpar(col=NA, fill=opt$ps_color))
        gp_ps1 <- gpar(col=opt$background_color, fontsize=opt$ps_fontsize, 
                      fontfamily=opt$ps_fontfamily, fontface=opt$ps_fontface)
        ps_grob1 <- textGrob(opt$ps_text, x=opt$ps_x, y=opt$ps_y, gp=gp_ps1)
        gp_ps2 <- gpar(col=opt$ps_color, fontsize=opt$ps_fontsize, 
                      fontfamily=opt$ps_fontfamily, fontface=opt$ps_fontface)
        ps_grob2 <- textGrob(opt$ps_text, x=c(0.2, 0.8), gp=gp_ps2) 
        border_grob <- shape$shape(gp=gpar(col=opt$border_color, fill=NA, lex=opt$border_lex))
        gl <- gList(background_grob, center_grob, ps_grob1, ps_grob2, border_grob)
    
        gTree(children=gl, name=piece_side)
    }
    cfg <- list(grob_fn.belt=pawnBeltGrob)
    grid.piece("belt_face", s=3, cfg=cfg)

.. figure:: {static}/images/knitr/docs-custom_grob_fn-three_suited_belt-1.png
    :align: center
    :alt: Pawn belts with three suit symbols

    Pawn belts with three suit symbols

.. [*] Technically if awkwardly you could replicate it by customizing the ``mat`` on the belt and putting two suit symbols separated by a bunch of whitespace as the directional mark symbols but the amount of whitespace needed would vary with the font and the fontsize so not a general solution and would require trial and error.

Low-level utilities
-------------------

piecepackr_ comes with several utility functions that can aid in the writing of custom grob functions.  For more documentation you can use the ``help`` function:

.. code:: r

    help("pp_shape")
    help("pp_utils")

In order to draw custom grob functions it may also be helpful to learn more about grid_'s API.
