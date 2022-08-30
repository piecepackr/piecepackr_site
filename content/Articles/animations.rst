Animations
==========

:date: 2019-04-09
:modified: 2020-01-11
:tags: ppgames-features
:summary: An example of making an animation directly using the {animation} and piecepackr_ packages and
  an example using ppgames_'s ``animate_game()`` function that can be used to animate games recorded 
  in `Portable Piecepack Notation`_.



.. include:: ../../links.rst

.. contents::

Directly using the {animations} package
---------------------------------------

.. note:: Besides the `animation package`_ you may find gifski_ and tweenr_ helpful.  

Here is a simple example of using the ``saveGIF()`` function from the `animation package`_ and ``piecepackr::grid.piece`` directly to make a GIF animation of a tic-tac-toe game of "Suns" versus "Moons" played on the "lines" of a single tile back:

|


.. sourcecode:: r
    

    library("animation")
    library("grid")
    library("piecepackr")
    draw_tictactoe_game_step <- function(n, cfg=list()) {
        grid.newpage()
        pushViewport(viewport(width=inch(4), height=inch(4)))
        if (n > 0) grid.piece("tile_back", cfg=cfg)
        if (n > 1) grid.piece("coin_back", suit=1, cfg=cfg, x=inch(2),y=inch(2))
        if (n > 2) grid.piece("coin_back", suit=2, cfg=cfg, x=inch(1),y=inch(2), angle=180)
        if (n > 3) grid.piece("coin_back", suit=1, cfg=cfg, x=inch(3),y=inch(1))
        if (n > 4) grid.piece("coin_back", suit=2, cfg=cfg, x=inch(1),y=inch(3), angle=180)
        if (n > 5) grid.piece("coin_back", suit=1, cfg=cfg, x=inch(1),y=inch(1))
        if (n > 6) grid.piece("coin_back", suit=2, cfg=cfg, x=inch(3),y=inch(3), angle=180)
        if (n > 7) grid.piece("coin_back", suit=1, cfg=cfg, x=inch(2),y=inch(1))
        if (n > 8) grid.segments(x0=inch(0.5), y0=inch(1), x1=inch(3.5), y1=inch(1), 
                                 gp=gpar(col="blue", lwd=4))
        popViewport()
    }
    draw_tictactoe_game <- function(cfg=list()) {
        for (ii in 0:9) { draw_tictactoe_game_step(ii, cfg) }
    }
    cfg <- game_systems("dejavu")$piecepack
    saveGIF({draw_tictactoe_game(cfg)}, movie.name="tictactoe.gif", 
        ani.height=480, ani.width=480, ani.res=120, ani.dev="png", ani.type="png")



.. figure:: {static}/images/knitr/tictactoe.gif
    :alt: Animation of a tic-tac-toe game
    :align: center

    Animation of a tic-tac-toe game

Using {ppgames}'s 'animate_game' function
-----------------------------------------

ppgames_ has a convenience function ``animate_game()`` that can be used to animate games recorded in `Portable Piecepack Notation`_:


.. sourcecode:: r
    

    library("ppgames", warn.conflicts=FALSE)
    dark_colorscheme <- list(suit_color="darkred,black,darkgreen,darkblue,black",
                          invert_colors.suited=TRUE, border_color="black", border_lex=2)
    piecepack_suits <- list(suit_text="\U0001f31e,\U0001f31c,\U0001f451,\u269c,\uaa5c", # 🌞,🌜,👑,⚜,꩜
                        suit_fontfamily="Noto Emoji,Noto Sans Symbols2,Noto Emoji,Noto Sans Symbols,Noto Sans Cham",
                        suit_cex="0.6,0.7,0.75,0.9,0.9")
    traditional_ranks <- list(use_suit_as_ace=TRUE, rank_text=",a,2,3,4,5")
    cfg3d <- list(width.pawn=0.75, height.pawn=0.75, depth.pawn=0.375, 
                       dm_text.pawn="", shape.pawn="convex6", invert_colors.pawn=TRUE,
                       edge_color.coin="tan", edge_color.tile="tan")
    cfg <- pp_cfg(c(piecepack_suits, dark_colorscheme, traditional_ranks, cfg3d))
    
    puzzle2 <- matrix(c(4,4,4,5,2,0,2,4,0,3,1,1,
                        1,2,5,3,3,5,3,2,5,1,0,0), nrow=2, byrow=TRUE)
    s2 <- solve_fujisan(coins=puzzle2)
    game <- read_ppn(textConnection(s2$ppn))[[1]]
    animate_game(game, file="fujisan.gif", cfg=cfg,
                 op_scale=1, op_angle=90, trans=op_transform)




.. figure:: {static}/images/knitr/fujisan.gif
    :alt: Animation of a Fuji-san game
    :align: center

    Animation of a Fuji-san game
