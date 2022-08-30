Hexpack
=======

:date: 2019-06-28
:modified: 2019-11-16
:tags: other-game-systems
:summary: The `Hexpack <https://boardgamegeek.com/boardgameexpansion/35424/hexpack>`_ is a piecepack_ expansion by `Daniel Wilcox <http://www.boardgamegeek.com/user/Erulisse>`_ and `Nathan Morse <http://www.boardgamegeek.com/user/ZefQuaavius>`_ that essentially introduces hexagonal tiles and triagonal coins.  In this demo we'll show how to configure a hexpack that matches our default_ piecepack and make a simple diagram using it as well as show how to use the built-in hexpack configurations_ that come with piecepackr_.



.. include:: ../../links.rst

The `Hexpack <https://boardgamegeek.com/boardgameexpansion/35424/hexpack>`_ is a piecepack_ expansion by `Daniel Wilcox <http://www.boardgamegeek.com/user/Erulisse>`_ and `Nathan Morse <http://www.boardgamegeek.com/user/ZefQuaavius>`_ that essentially introduces hexagonal tiles and triagonal coins.  In this demo we'll show how to configure a hexpack that matches our default_ piecepack and make a simple diagram using it as well as show how to use the built-in hexpack configurations_ that come with piecepackr_.

.. contents::

Configuring a hexpack
---------------------

The trickiest part of configuring a hexpack is figuring out the correct dimensions for the hexagonal tiles.  The suggested size of the hexagonal tiles in a hexpack is one that allows the hexagons to circumscribe a 2" circumference circle which implies that they in turn are circumscribed by a ``4 / sqrt(3)`` circumference circle:  


.. sourcecode:: r
    

    library("piecepackr")
    hexpack <- pp_cfg(list(shape.tile="convex6", border_lex=3, 
                       shape_t.tile="60",  dm_t.tile_face=-90,
                       width.tile=4/sqrt(3), height.tile=4/sqrt(3),
                       shape.coin="convex3", invert_colors.suited=TRUE)) 


When making hex diagrams it is often helpful to think in `polar coordinates`_ so piecepackr_ provides the helper functions ``to_x``, ``to_y``, ``to_t``, and ``to_r`` to help developers convert back and forth between polar coordinates and Cartesian coordinates.  We'll make a simple diagram using these functions and the hexpack configuration we just made:  


.. sourcecode:: r
    

    library("tibble")
    
    x0 <- 5
    y0 <- 4.5
    df_t1 <- tibble(piece_side="tile_back", x=x0, y=y0)
    
    theta <- seq(90, by=-60, length.out=6)
    r <- 0.7
    df_c <- tibble(piece_side="coin_face", rank=1:6,
                   x=x0+to_x(theta,r), y=y0+to_y(theta,r),
                   angle=theta+90)
    
    r <- 2
    df_t2 <- tibble(piece_side="tile_face", 
                    suit=1:6%%4+1, rank=1:6,
                    x=x0+to_x(theta,r), y=y0+to_y(theta,r), 
                    angle=theta+-90)
    
    r <- 6/sqrt(3)
    df_t3 <- tibble(piece_side="tile_back",
                    x=x0+to_x(theta+30, r),
                    y=y0+to_y(theta+30, r))
    
    df <- dplyr::bind_rows(df_t1, df_c, df_t2, df_t3)
    pmap_piece(df, cfg=hexpack, default.units="in", 
               op_scale=0.5, op_angle=60, trans=op_transform)

.. figure:: {static}/images/knitr/games-hexpack-diagram-1.png
    :align: center
    :alt: Example hexpack diagram
    :width: 60%

    Example hexpack diagram



Using the built-in hexpacks
---------------------------

piecepackr_ provides a couple built-in hexpack_ configurations_ via the function ``game_systems`` [#v1.2]_:


.. sourcecode:: r
    

    df$cfg <- "hexpack"
    pmap_piece(df, envir=game_systems("dejavu"), default.units="in", 
               op_scale=0.5, op_angle=60, trans=op_transform)

.. figure:: {static}/images/knitr/games-hexpack-diagram2-1.png
    :align: center
    :alt: Example hexpack diagram with the built-in 'dejavu' hexpack
    :width: 60%

    Example hexpack diagram with the built-in 'dejavu' hexpack



.. [#v1.2] New in piecepackr_ version 1.2.


