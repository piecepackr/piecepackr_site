Tablut
======

:date: 2019-05-17
:modified: 2021-01-25
:tags: piecepack-games
:summary: `Tablut <{static}/share/rules/tablut.pdf>`_ is a historical (hnefa)tafl game played by the Sámi people until at least the 1700s whose rules were written down by the Swedish naturalist Linnaeus in 1732.  Below is a starting diagram for playing a game of Tablut with a piecepack.



`Tablut <{static}/share/rules/tablut.pdf>`_ is a historical (hnefa)tafl game played by the Sámi people until at least the 1700s whose rules were written down by the Swedish naturalist Linnaeus in 1732.  Below is a starting diagram for playing a game of Tablut with a piecepack.


.. sourcecode:: r
    

    library("piecepackr")
    library("ppgames", warn.conflicts=FALSE)
    cfg <- pp_cfg(list(suit_text="🌞,🌜,👑,⚜,꩜",
         suit_cex="0.6,0.7,0.75,0.9,0.9",
        suit_fontfamily="Noto Emoji,Noto Sans Symbols2,Noto Emoji,Noto Sans Symbols,Noto Sans Cham",
        suit_color="darkred,black,darkgreen,darkblue,black",
        border_lex=4, border_color="black", mat_width.tile_back=0.05, mat_color="white",
        invert_colors.suited = TRUE, edge_color.coin="tan", edge_color.tile="tan",
        shape.pawn="convex6", depth.pawn=1.0, height.pawn=0.75, width.pawn=0.75, dm_text.pawn=""
    ))
    df <- df_tablut(die_width = 0.5)
    pmap_piece(df, cfg=cfg, default.units="in", trans=op_transform, op_scale=0.7)

.. figure:: {static}/images/knitr/games-tablut-starting-diagram-1.png
    :align: center
    :alt: Starting diagram for a game of Tablut
    :width: 60%

    Starting diagram for a game of Tablut

And here is animation of a game of Tablut:


.. sourcecode:: r
    

    game <- read_ppn(system.file("ppn/tablut.ppn", package = "ppgames"))[[1]]
    ppgames::animate_game(game, file = "../images/knitr/tablut.gif",
                          cfg = cfg, trans = op_transform, op_scale = 0.7,
                          n_transitions = 6, n_pauses = 3, fps = 9)


.. figure:: {static}/images/knitr/tablut.gif
    :alt: Animation of a Tablut game
    :align: center

    Animation of a Tablut game


