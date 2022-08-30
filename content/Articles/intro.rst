Intro to piecepackr's API
=========================

:date: 2019-04-11
:modified: 2019-04-28
:tags: piecepackr-features
:summary: piecepackr_ is an R_ package to easily make piecepack_ graphics.  It can be used to make piecepack game diagrams and animations_ as well as `Print & Play`_ layouts so you can `make your own piecepack`_.



.. include:: ../../links.rst

piecepackr_ is an R_ package to easily make piecepack_ graphics.  It can be used to make piecepack game diagrams and animations_ as well as `Print & Play`_ layouts so you can `make your own piecepack`_.

The core function is ``grid.piece()`` which can be used to draw any piecepack component:


.. sourcecode:: r
    

    library("piecepackr")
    grid.piece("tile_face", s=1:4, r=1:4, x=inch(seq(1, 7, by=2)))

.. figure:: {static}/images/knitr/docs-intro-dc1-1.png
    :align: center
    :alt: tile faces

    tile faces


.. sourcecode:: r
    

    grid.piece("coin_face", r=1:4, x=inch(seq(0.5, 3.5)))

.. figure:: {static}/images/knitr/docs-intro-dc2-1.png
    :align: center
    :alt: coin faces

    coin faces


.. sourcecode:: r
    

    grid.piece("pawn_face", s=3)

.. figure:: {static}/images/knitr/docs-intro-dc3-1.png
    :align: center
    :alt: clubs pawn (face)

    clubs pawn (face)


.. sourcecode:: r
    

    grid.piece("die_face", s=2, r=1)

.. figure:: {static}/images/knitr/docs-intro-dc4-1.png
    :align: center
    :alt: null of spades die (face)

    null of spades die (face)

piecepackr_ features an advanced configuration system that allows users to customize the appearance of the piecepack being used in their graphics.  By default_ it uses an accessible french-suited configuration that should work out of the box on several OSes without the user needing to mess around with their system fonts but user's can customize their piecepack's appearance via use of a `configuration list`_:


.. sourcecode:: r
    

    dark_colorscheme <- list(suit_color="darkred,black,darkgreen,darkblue,black",
                             invert_colors.suited=TRUE)
    piecepack_suits <- list(suit_text="\U0001f31e,\U0001f31c,\U0001f451,\u269c,\uaa5c", # 🌞,🌜,👑,⚜,꩜
                            suit_fontfamily="Noto Emoji,Noto Sans Symbols2,Noto Emoji,Noto Sans Symbols,Noto Sans Cham",
                            suit_cex="0.6,0.7,0.75,0.9,0.9")
    traditional_ranks <- list(use_suit_as_ace=TRUE, rank_text=",a,2,3,4,5")
    cfg <- c(piecepack_suits, dark_colorscheme, traditional_ranks)
    grid.piece("tile_face", s=1:4, r=1:4, x=inch(seq(1, 7, by=2)), cfg=cfg)

.. figure:: {static}/images/knitr/docs-intro-dc1t-1.png
    :align: center
    :alt: tile faces

    tile faces


.. sourcecode:: r
    

    grid.piece("coin_face", r=1:4, x=inch(seq(0.5, 3.5)), cfg=cfg)

.. figure:: {static}/images/knitr/docs-intro-dc2t-1.png
    :align: center
    :alt: coin faces

    coin faces


.. sourcecode:: r
    

    grid.piece("pawn_face", s=3, cfg=cfg)

.. figure:: {static}/images/knitr/docs-intro-dc3t-1.png
    :align: center
    :alt: crowns pawn (face)

    crowns pawn (face)


.. sourcecode:: r
    

    grid.piece("die_face", s=2, r=1, cfg=cfg)

.. figure:: {static}/images/knitr/docs-intro-dc4t-1.png
    :align: center
    :alt: null of moons die (face)

    null of moons die (face)

The ``preview_layout`` grob allows one to see a preview of a given configuration list:


.. sourcecode:: r
    

    grid.piece("preview_layout", cfg=cfg)

.. figure:: {static}/images/knitr/docs-intro-draw_preview-1.png
    :align: center
    :alt: 'preview_layout' allows one to see a preview of a configuration
    :width: 60%

    'preview_layout' allows one to see a preview of a configuration

Once you have a configuration you like one can use ``save_print_and_play`` to make a `Print & Play`_ pdf of your piecepack and ``save_piece_images`` to make individual images of every piecepack component (in case you would prefer to make your own layout or rule diagram in software like Inkscape):

.. code:: r

    save_print_and_play(cfg, "my_piecepack.pdf", size="letter")
    save_piece_images(cfg)

If you will be drawing a bunch of piecepack graphics you may want to use the ``pp_cfg`` function which will add a "component opt" cache to your configuration (will make ``grid.piece`` work faster):

.. code:: r

    cfg <- pp_cfg(cfg)

If you are comfortable manipulating R_ data frames ``pmap_piece`` is a wrapper around ``grid.piece`` that can digest data frame input:


.. sourcecode:: r
    

    df <- tibble::tribble(~piece_side, ~suit, ~x, ~y,
                          "tile_back", NA, 2, 2,
                          "coin_back", 1, 2, 2,
                          "coin_back", 2, 1, 2,
                          "coin_back", 1, 3, 1,
                          "coin_back", 2, 1, 3,
                          "coin_back", 1, 1, 1,
                          "coin_back", 2, 3, 3,
                          "coin_back", 1, 2, 1)
    df$angle <- ifelse(df$suit == 2, 180, 0)
    pmap_piece(df, cfg=cfg, default.units="inches")

.. figure:: {static}/images/knitr/docs-intro-pmap_piece-1.png
    :align: center
    :alt: Tic-tac-toe example

    Tic-tac-toe example

More documentation about piecepackr's API can be found in the package's `man pages`_.
