Backgammon
==========

:date: 2019-05-17
:tags: piecepack-games
:summary: `Backgammon <{static}/share/rules/backgammon.pdf>`_ is one of the oldest known board games. Like other classic board games like checkers and chess it is also possible to play with a single piecepack_.  We illustrate the starting diagram for playing a game of backgammon with a piecepack using a paired suit-color design.



.. include:: ../../links.rst

`Backgammon <{static}/share/rules/backgammon.pdf>`_ is one of the oldest known board games. Like other classic board games like checkers and chess it is also possible to play with a single piecepack_.  Below is a starting diagram for playing a game of backgammon with a piecepack using a paired suit-color design.


.. sourcecode:: r
    

    library("grid")
    library("piecepackr")
    library("ppgames")
    cfg <- pp_cfg(list(suit_text="🌞,🌜,👑,⚜,꩜",
                       suit_cex="0.6,0.7,0.75,0.9,0.9",
                       suit_fontfamily="Noto Emoji,Noto Sans Symbols2,Noto Emoji,Noto Sans Symbols,Noto Sans Cham",
                       suit_color="#D55E00,#000000,#F0E442,#0072B2,#009E73",
                       background_color="#000000,#D55E00,#0072B2,#F0E442,white",
                       annotation_color = "#E69F00"
    ))
    pmap_piece(df_backgammon(), cfg=cfg, default.units="in")

.. figure:: {static}/images/knitr/games-backgammon-starting-diagram-1.png
    :align: center
    :alt: Starting diagram for a game of backgammon
    :width: 60%

    Starting diagram for a game of backgammon


