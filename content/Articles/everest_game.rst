Everest
=======

:date: 2019-10-07
:tags: piecepack-games
:summary: `Everest <http://www.ludism.org/ppwiki/Everest>`__ is a piecepack game by Mark A. Biggar featuring programmed movement.  It is a "King of the Hill" game that features a visually striking board with the tiles physically arranged as a hill.  Here is the starting diagram for it using an "icy" piecepack tile color scheme to match its snowy Himalayan Yeti theme:



.. include:: ../../links.rst

`Everest <http://www.ludism.org/ppwiki/Everest>`__ is a piecepack game by Mark A. Biggar featuring programmed movement.  It is a "King of the Hill" game that features a visually striking board with the tiles physically arranged as a hill.  Here is the starting diagram for it using an "icy" piecepack tile color scheme to match its snowy Himalayan Yeti theme:


.. sourcecode:: r
    

    library("piecepackr")
    library("ppgames", warn.conflicts=FALSE)
    
    icy_colorscheme <- list(suit_color="darkred,black,darkgreen,darkblue,darkblue", border_color="black", border_lex=6,
                             edge_color.pawn="black", edge_color.tile="lightblue", depth.pawn=0.25)
    piecepack_suits <- list(suit_text="\U0001f31e,\U0001f31c,\U0001f451,\u269c,\uaa5c", 
                        suit_fontfamily="Noto Emoji,Noto Sans Symbols2,Noto Emoji,Noto Sans Symbols,Noto Sans Cham",
                        suit_cex="0.6,0.7,0.75,0.9,0.9")
    cfg <- pp_cfg(c(piecepack_suits, icy_colorscheme))
    pmap_piece(df_everest(), cfg=cfg, default.units="in", op_scale=1.0, trans=op_transform)

.. figure:: {static}/images/knitr/games-everest-starting-diagram-1.png
    :align: center
    :alt: Starting diagram for a game of Everest
    :width: 60%

    Starting diagram for a game of Everest


