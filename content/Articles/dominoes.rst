Dominoes and Standard 6-sided Dice
==================================

:date: 2020-02-16
:tags: other-game-systems
:summary: Version 1.3 of piecepackr_ comes with built-in configurations for double-12 dominoes and standard six-sided dice in six colors via the ``game_systems()`` function.



.. include:: ../../links.rst

.. contents::

Version 1.3 of piecepackr_ comes with built-in configurations for double-12 dominoes and standard six-sided dice in six colors via the ``game_systems()`` function.

The ``dice`` configuration provides standard six-sided dice with the suit controlling the color and the rank controlling the number of pips.  There are seven dominoes configurations: ``dominoes``, ``dominoes_black``, ``dominoes_blue``, ``dominoes_green``, ``dominoes_red``, ``dominoes_white``, and ``dominoes_yellow`` with the "rank" controlling the number of pips on the "top" side and the "suit" controlling the number of pips on the "bottom" side. Here is an example diagram:


.. sourcecode:: r
    

    library("piecepackr")
    library("grid")
    library("tibble")
    
    envir <- game_systems("dejavu")
    df_dominoes <- tibble(piece_side = "tile_face", x=rep(4:1, 3), y=rep(2*3:1, each=4), suit=1:12, rank=1:12+1,
                          cfg = paste0("dominoes_", rep(c("black", "red", "green", "blue", "yellow", "white"), 2)))
    df_tiles <- tibble(piece_side = "tile_back", x=5.5, y=c(2,4,6), suit=1:3, rank=1:3, cfg="piecepack")
    df_dice <- tibble(piece_side = "die_face", x=6, y=0.5+1:6, suit=1:6, rank=1:6, cfg="dice")
    df_coins1 <- tibble(piece_side = "coin_back", x=5, y=0.5+1:4, suit=1:4, rank=1:4, cfg="piecepack")
    df_coins2 <- tibble(piece_side = "coin_face", x=5, y=0.5+5:6, suit=1:2, rank=1:2, cfg="piecepack")
    df <- rbind(df_dominoes, df_tiles, df_dice, df_coins1, df_coins2)
    pmap_piece(df, default.units="in", envir=envir, op_scale=0.5, trans=op_transform)

.. figure:: {static}/images/knitr/games-dominoes-diagram-1.png
    :align: center
    :alt: Double-12 dominoes and standard 6-sided dice
    :width: 60%

    Double-12 dominoes and standard 6-sided dice
