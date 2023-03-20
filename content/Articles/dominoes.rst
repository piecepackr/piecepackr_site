Dominoes
========

:date: 2020-02-16
:modified: 2023-03-06
:tags: other-game-systems
:summary: piecepackr_ comes with built-in configurations for double-18 dominoes in six color schemes as well as Chinese dominoes in two color schemes via the ``game_systems()`` function.



.. include:: ../../links.rst

.. contents::

piecepackr_ comes with built-in configurations for double-18 dominoes in six color schemes as well as Chinese dominoes in two color schemes via the ``game_systems()`` function.

Western dominoes and dice
-------------------------

.. note:: Double-12 dominoes were introduced in piecepackr_ v1.3 and were extended to double-18 dominoes in v1.9.

There are seven dominoes configurations: ``dominoes``, ``dominoes_black``, ``dominoes_blue``, ``dominoes_green``, ``dominoes_red``, ``dominoes_white``, and ``dominoes_yellow`` with the "rank" controlling the number of pips on the "top" side and the "suit" controlling the number of pips on the "bottom" side.  Currently there is no difference in appearance between the ``dominoes`` and ``dominoes_white`` configurations returned by ``game_systems()`` [#]_.  The ``dice`` configuration provides standard six-sided dice with the suit controlling the color and the rank controlling the number of pips [#]_.  Here is an example diagram:


.. sourcecode:: r
    

    library("piecepackr")
    library("grid")
    library("tibble")
    
    envir <- game_systems()
    df_dominoes <- tibble(piece_side = "tile_face", 
                          x=rep(4:1, 3), y=rep(2*3:1, each=4), 
                          suit=1:12, rank=7:18+1,
                          cfg = paste0("dominoes_", 
                                       rep(c("black", "red", "green", "blue", "yellow", "white"), 2)))
    df_dice <- tibble(piece_side = "die_face", x=6, y=0.5+1:6, suit=1:6, rank=1:6, cfg="dice")
    df <- rbind(df_dominoes, df_dice)
    pmap_piece(df, default.units="in", envir=envir, op_scale=0.5, trans=op_transform)

.. figure:: {static}/images/knitr/games-dominoes-diagram-1.png
    :align: center
    :alt: Double-18 dominoes and standard 6-sided dice
    :width: 60%

    Double-18 dominoes and standard 6-sided dice

.. [#] Semantically the "dominoes" is meant to represent a more general notion of a dominoes set.  ``game_systems()`` implements it as a dominoes set with black pips on white tiles but users could theoretically replace it with alternative dominoes set implementations such as tiles with colored numbers.  Semantically the various colored dominoes sets are meant to be visually distinct with each other and to visually match the pieces from other game systems-in particular the piecepack_ game `Japan <https://www.ludism.org/ppwiki/Japan>`_ assumes two different double-6 dominoes sets that match two of the piecepack suits.

.. [#] Technically, each of the dominoes configurations also has matching six-sided "die" pieces.  These are equivalent to the pipped six-sided dice in ``dice`` when using the configurations returned by ``game_systems()``.  However semantically they need not be equivalent e.g. if you had a modified "dominoes" configuration with colored numbers instead of pips and also updated its "die" pieces to also use colored numbers instead of pips then these dice may no longer match the dice from the "dice" configuration.

Chinese dominoes and dice
-------------------------

.. note:: Chinese dominoes were introduced in piecepackr_ v1.13.

The configurations ``dominoes_chinese`` and ``dominoes_chinese_black`` provide `Chinese dominoes <https://en.wikipedia.org/wiki/Chinese_dominoes>`_ and `Asian-style dice <https://en.wikipedia.org/wiki/Dice#Arrangement>`_.  ``dominoes_chinese`` has a white background with black and red pips while ``dominoes_chinese_black`` has a black background with white and red pips.

|
|


.. sourcecode:: r
    

    library("piecepackr")
    library("tibble")
    
    df1 <- tibble(piece_side = "tile_face",
                  suit = c(rep(1, 6L), 2L, rep(2, 4L), rep(3, 3L), 3, rep(4, 3), 5, 5, 6),
                  rank = c(1:6, 2L, 3:6, 3:5, 6, 4:6, 5:6, 6),
                  cfg = rep(c("dominoes_chinese", "dominoes_chinese_black", "dominoes_chinese"),
                            each = 7L),
                  x = rep(1:7, 3L),
                  y = c(rep(c(1.5, 4.0, 6.5), each = 7L)))
    df2 <- tibble(piece_side = "die_face",
                  suit = 1, rank = 1:6,
                  cfg = rep(c("dominoes_chinese", "dominoes_chinese_black", "dominoes_chinese"),
                            each = 2L),
                  x = 8.5, y = c(1, 2.25, 3.5, 4.75, 6.0, 7.25))
    df <- rbind(df1, df2)
    
    pmap_piece(df, envir = game_systems(), default.units = "in",
               trans = op_transform, op_scale = 0.5)

.. figure:: {static}/images/knitr/games-dominoes-chinese-1.png
    :align: center
    :alt: Chinese dominoes and 6-sided dice
    :width: 60%

    Chinese dominoes and 6-sided dice
