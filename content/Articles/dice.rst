Dice
====

:date: 2023-03-20
:tags: other-game-systems
:summary: piecepackr_ comes with built-in configurations for a variety of dice via the ``game_systems()`` function.



.. include:: ../../links.rst

.. contents::

piecepackr_ comes with built-in configurations for a variety of dice via the ``game_systems()`` function.

Traditional six-sided pipped dice
---------------------------------

.. note:: Chinese dominoes were introduced in piecepackr_ v1.13.

The ``dice`` configuration provides standard pipped dice in six colors with the suit controlling the color and the rank controlling the number of pips [#]_.  The ``dominoes_chinese`` and ``dominoes_chinese_black`` configurations provide `Asian-style dice <https://en.wikipedia.org/wiki/Dice#Arrangement>`_ (and `Chinese dominoes <https://en.wikipedia.org/wiki/Chinese_dominoes>`_).  ``dominoes_chinese`` has a white background with black and red pips while ``dominoes_chinese_black`` has a black background with white and red pips.


.. sourcecode:: r
    

    library("piecepackr")
    envir <- game_systems()
    grid.piece("die_face", suit = 1:6, rank = 1:6, cfg = envir$dice,
               x = 1:6, y = 1, default.units = "in", op_scale = 0.5)
    grid.piece("die_face", suit = 1:6, rank = 1:6, 
               cfg = rep(c("dominoes_chinese", "dominoes_chinese_black"), length.out = 6), envir = envir,
               x = 1:6, y = 2, default.units = "in", op_scale = 0.5)

.. figure:: {static}/images/knitr/games-dice-traditional-1.png
    :align: center
    :alt: Traditional pipped dice (Western and Asian-style)
    :width: 60%

    Traditional pipped dice (Western and Asian-style)

.. [#] The die pieces in other configurations such as the various "dominoes" configurations may also contain standard six-sided dice when appropriate.

Polyhedral dice
---------------

.. note:: The polyhedral dice were introduced in piecepackr_ v1.13.

The ``dice_d4``, ``dice_numeral``, ``dice_d8``, ``dice_d10``, ``dice_d10_percentile``, ``dice_d12``, and ``dice_d20`` configurations provide the seven `polyhedral dice <https://en.wikipedia.org/wiki/Dice#Polyhedral_dice>`_ most commonly used by wargames, roleplaying games, and trading card games in six colors controlled by suit.

|


.. sourcecode:: r
    

    library("piecepackr")
    envir <- game_systems()
    grid.piece("die_face", suit = c(1:6, 1), rank = 1:7,
               cfg = paste0("dice_", c("d4", "numeral", "d8", "d10_percentile", "d10", "d12", "d20")),
               envir = envir, x = 1:7, y = 1, default.units = "in", op_scale = 0.5)

.. figure:: {static}/images/knitr/games-dice-polyhedral-1.png
    :align: center
    :alt: Polyhedral dice
    :width: 60%

    Polyhedral dice

Fudge/Fate dice
---------------

.. note:: The Fudge dice were introduced in piecepackr_ v1.11.

The ``dice_fudge`` configuration use the six-sided `Fudge dice <https://en.wikipedia.org/wiki/Fudge_(role-playing_game_system)#Fudge_dice>`_ with two plus, two minus, and two blank faces most commonly used in the `Fudge <https://en.wikipedia.org/wiki/Fudge_(role-playing_game_system)>`_ and `Fate <https://en.wikipedia.org/wiki/Fate_(role-playing_game_system)>`_ roleplaying games.

|


.. sourcecode:: r
    

    library("piecepackr")
    grid.piece("die_face", suit = 1:6, rank = 1:6, cfg = game_systems()$dice_fudge,
               x = 1:6, y = 1, default.units = "in", op_scale = 0.5)

.. figure:: {static}/images/knitr/games-dice-fudge-1.png
    :align: center
    :alt: Fudge dice
    :width: 60%

    Fudge dice

Piecepack dice
--------------

.. note:: The inverted piecepack was introduced in piecepackr_ v1.10.

The ``piecepack``, ``dual_piecepacks_expansion``, ``playing_cards_expansion``, and ``piecepack_inverted`` configurations provide piecepack_ dice [#]_.

|
|


.. sourcecode:: r
    

    library("piecepackr")
    envir <- game_systems("dejavu")
    cfg <- rep(c("piecepack", "dual_piecepacks_expansion", "playing_cards_expansion", "piecepack_inverted"), each = 4)
    grid.piece("die_face", suit = rep(1:4, 4), rank = 2, 
               cfg = cfg, envir = envir,
               x = rep(1:4, each = 4), y = rep(1:4, 4), 
               default.units = "in", op_scale = 0.5)

.. figure:: {static}/images/knitr/games-dice-piecepack-1.png
    :align: center
    :alt: Piecepack dice
    :width: 60%

    Piecepack dice

.. [#] There are also piecepack dice in the ``hexpack`` and ``subpack`` configurations but these are just small versions of the ``piecepack`` dice.

Chess dice
----------

.. note:: The ``chess1`` and ``chess2`` configurations were introduced in piecepackr_ v1.6.

The ``chess1`` and ``chess2`` configurations provide chess dice.

|
|
|


.. sourcecode:: r
    

    library("piecepackr")
    envir <- game_systems("dejavu")
    grid.piece("die_face", suit = 1:6, rank = 1:6, 
               cfg = envir$chess1, x = 1:6, y = 1,
               default.units = "in", op_scale = 0.5)

.. figure:: {static}/images/knitr/games-dice-chess-1.png
    :align: center
    :alt: Chess dice
    :width: 60%

    Chess dice

Custom dice
-----------

piecepackr_ allows for custom six-sided dice.  One can use configurations_ and `custom grob functions`_ to customize the faces of the dice and use the ``die_arrangement`` configuration_ to customize the ordering, rotation, and size of the faces when visualized in a `3D projection <{filename}/Articles/projections.rst>`_ or arranged in a `Print & Play`_ layout.

