Game starting arrangement functions
===================================

:date: 2019-10-25
:modified: 2022-07-25
:tags: ppgames-features, piecepack-games
:summary: The package ppgames_ contains functions that generate the starting piece arrangements for several `piecepack games`_.  These functions return data frames that can be used directly with ``piecepackr::pmap_piece()`` or ``ppgames::cat_piece()`` to generate `piecepack game`_ diagrams_ or they can be used with ppgames_' `Portable Piecepack Notation`_ parser ``read_ppn()`` to initially setup the game pieces.

The package ppgames_ contains functions that generate the starting piece arrangements for several `piecepack games`_.  These functions return data frames that can be used directly with ``piecepackr::pmap_piece`` or ``ppgames::cat_piece`` to generate `piecepack game`_ diagrams_ or they can be used with ppgames_' `Portable Piecepack Notation`_ parser ``read_ppn`` to initially setup the game pieces.



.. include:: ../../links.rst

.. contents::

Directly generating starting diagrams
-------------------------------------

The game start functions all return a data frame that can be used directly with ``piecepackr::pmap_piece`` or ``ppgames::cat_piece``:

.. code:: r

    library("ppgames")
    cat_piece(df_fide_chess())

.. image:: https://trevorldavis.com/share/piecepack/unicode_piecepack_alt_5.png
    :alt: Unicode text diagram for Chess
    :align: center

.. code:: r 

    download.file("https://trevorldavis.com/piecepackr/share/demo_cfgs.RData")
    cfgs <- new.env()
    load("demo_cfgs.RData", envir=cfgs)
    pmap_piece(df_fide_chess(), cfg=cfgs$chess5, op_scale=0.5, 
               trans=op_transform, default.units="in")

.. image:: {static}/share/rules/fide-chess.png
    :alt: 3D diagram for Chess
    :align: center

Use with Portable Piecepack Notation
------------------------------------

The game start functions can also be used with `Portable Piecepack Notation`_ to initially set the game pieces via the metadata field ``GameType``::

    GameType: Four Field Kono

    1. b1:b3 1... d3:b3 2. c1:c3 2... a3:c3 3. c2-c1 3... b4:b2 4. a1-b1 4... b3:b1
    5. d1:b1 5... c3-c2 6. a2-a3 6... b2:d2 7. a3-b3 7... c4-c3 8. c1-d1 8... d4-d3
    9. b1-b2 9... d2:b2 10. b3-a3 10... b2-b1 {Player 1's loss is assured with the
     separation of their two remaining pieces and they should resign in a real game}
    11. a3-a2 11... b1-c1 12. d1-d2 12... c1-d1 13. a2-a3 13... a4-b4
    14. a3-a4 14... b4-c4 15. a4-b4 15... c4-d4 16. b4-a4 16... d4:d2 {Player 2 wins}

.. image:: https://www.trevorldavis.com/share/piecepack/four_field_kono_example.gif
    :alt: Four Field Kono example

It is also possible to pass in arguments to the game start function by passing a "mapping" to the ``GameType`` field::

    ---
    GameType:
      Name: Fujisan
      Coins: "44452n24n3aa/a25335325ann"
    ...
    1. a1-b1 2. n2-k2 3. b1-e1 4. e1-j1 5. j1-j2 6. j2-l2 7. k2-m2
    8. m2-m1 9. l2-l1 10. n1-k1 11. m1-i1 12. i1-d1 13. d1-d2 14. l1-i1
    15. i1-i2 16. k1-k2 17. k2-e2 18. i2-c2 19. a2-f2 20. e2-h2 21. h2-g2
    22. c2-h2 23. h2-h1 24. d2-h2 25. f2-b2 26. b2-b1 27. b1-g1

.. image:: {static}/images/knitr/fujisan.gif
    :alt: Animation of a Fuji-san game
    :align: center

In particular for supported games playable with either a piecepack_ or another game system (like a checkers board) one can inform PPN of the alternative game system to use via a ``System`` argument to the ``GameType`` field::

    ---
    GameType:
      Name: Four Field Kono
      System: Checkers
    ...
    1. b1:b3 1... d3:b3 2. c1:c3 2... a3:c3 3. c2-c1 3... b4:b2 4. a1-b1 4... b3:b1
    5. d1:b1 5... c3-c2 6. a2-a3 6... b2:d2 7. a3-b3 7... c4-c3 8. c1-d1 8... d4-d3
    9. b1-b2 9... d2:b2 10. b3-a3 10... b2-b1 {Player 1's loss is assured with the
     separation of their two remaining pieces and they should resign in a real game}
    11. a3-a2 11... b1-c1 12. d1-d2 12... c1-d1 13. a2-a3 13... a4-b4
    14. a3-a4 14... b4-c4 15. a4-b4 15... c4-d4 16. b4-a4 16... d4:d2 {Player 2 wins}

.. image:: https://www.trevorldavis.com/share/piecepack/four-field-kono-trad.gif
    :alt: Four Field Kono example using checkers and a board instead of a piecepack

Supported Game Start Functions
------------------------------

Contained in piecenikr
~~~~~~~~~~~~~~~~~~~~~~

Please note some Looney Pyramids / piecepack hybrids like `Alien City`_ are contained in the ppgames_ package.

.. list-table:: Game Start Functions contained in piecenikr
    :header-rows: 1
    :widths: 30, 30, 40

    * - game
      - df_names
      - comment 
    * - `Martian Chess <https://www.looneylabs.com/content/martian-chess>`_
      - df_martian_chess
      -

Contained in ppgames
~~~~~~~~~~~~~~~~~~~~

.. figure:: {static}/images/knitr/piecepack_games.gif
    :alt: Some games supported in ppgames
    :align: center

    Some games supported in ppgames

.. list-table:: Game Start Functions contained in ppgames
    :header-rows: 1
    :widths: 30, 20, 10, 40

    * - game
      - df_names
      - ruleset
      - comment 
    * - `Alice Chess <https://en.wikipedia.org/wiki/Alice_chess>`_
      - df_alice_chess
      -  
      -
    * - `Alien City <https://www.ludism.org/ppwiki/AlienCity>`_
      - df_alien_city
      -
      -
    * - `Alquerque <https://en.wikipedia.org/wiki/Alquerque>`_
      - df_alquerque
      - X
      -
    * - `Awithlaknannai Mosona <https://en.wikipedia.org/wiki/Awithlaknannai_Mosona>`_
      - df_awithlaknannai_mosona
      - X
      -
    * - `Backgammon <https://www.ludism.org/ppwiki/Backgammon>`_
      - df_backgammon
      - X
      -
    * - `Brandubh <http://tafl.cyningstan.com/page/171/brandub>`_
      - df_brandubh
      -
      -
    * - `Breakthrough <https://en.wikipedia.org/wiki/Breakthrough_(board_game)>`_
      - df_breakthrough
      -
      -
    * - `Cell Management <https://www.ludism.org/ppwiki/CellManagement>`_
      - df_cell_management
      -
      -
    * - `Chaturaji <https://www.ludism.org/ppwiki/Chaturaji>`_
      - df_chaturaji
      - X
      -
    * - `(American) Checkers <https://www.ludism.org/ppwiki/Checkers>`_
      - df_american_checkers, df_english_draughts, df_checkers
      - X
      -
    * - `(International) Chess <https://www.ludism.org/ppwiki/Checkers>`_
      - df_international_chess, df_chess
      - X
      -
    * - `Chinese Checkers <https://www.ludism.org/ppwiki/ChineseCheckers>`_
      - df_chinese_checkers, df_mini_halma
      -
      - A mini Halma variant
    * - `Cribbage (Board) <https://www.ludism.org/ppwiki/Cribbage>`_
      - df_cribbage, df_cribbage_board
      - X
      - A (piecepack) cribbage board
    * - `Coin Collectors <https://www.ludism.org/ppwiki/CoinCollectors>`_
      - df_coin_collectors
      -
      -
    * - `Crossings <https://en.wikipedia.org/wiki/Crossings_(game)>`_
      - df_crossings
      -
      -
    * - `Desfases <https://www.ludism.org/ppwiki/Desfases>`_
      - df_desfases
      -
      -
    * - `Easy Slider <https://www.ludism.org/ppwiki/EasySlider>`_
      - df_easy_slider
      -
      -
    * - `Evade <https://www.ludism.org/ppwiki/Evade>`_
      - df_evade
      -
      -
    * - `Everest <https://www.ludism.org/ppwiki/Everest>`_
      - df_everest
      -
      -
    * - `Four Blind Mice <https://www.ludism.org/ppwiki/FourBlindMice>`_
      - df_four_blind_mice
      -
      - 
    * - `Four Field Kono <https://www.ludism.org/ppwiki/FourFieldKono>`_
      - df_four_field_kono
      - X
      - 
    * - `Four Seasons Chess <https://www.chessvariants.com/historic.dir/4seiz.html>`_
      - df_four_seasons_chess
      -  
      -
    * - `Froggy Bottom <https://www.ludism.org/ppwiki/FroggyBottom>`_
      - df_froggy_bottom
      -
      -
    * - `Fujisan <https://www.ludism.org/ppwiki/Fuji-san>`_
      - df_fujisan
      -
      -
    * - `Grasshoper <http://www.cyningstan.com/game/71/grasshopper>`_
      - df_grasshopper
      -
      -
    * - `Iceberg <https://www.ludism.org/ppwiki/Iceberg>`_
      - df_iceberg
      -
      -
    * - `Ice Floe <https://www.ludism.org/ppwiki/IceFloe>`_
      - df_ice_floe
      -
      -
    * - `Jul-Gono <https://www.ludism.org/ppwiki/JulGono>`_
      - df_jul_gono
      -
      - 
    * - `Landlocked <https://www.ludism.org/ppwiki/Landlocked>`_
      - df_landlocked
      -
      -
    * - `Ley Lines <https://www.ludism.org/ppwiki/LeyLines>`_
      - df_ley_lines
      -
      -
    * - `Lines of Action <https://en.wikipedia.org/wiki/Lines_of_Action>`_
      - df_lines_of_action
      -
      -
    * - `Ludo <https://en.wikipedia.org/wiki/Ludo_(board_game)>`_
      - df_ludo
      - X
      -
    * - `Mathrix <https://www.ludism.org/ppwiki/Mathrix>`_
      - df_mathrix
      -
      -
    * - `Nine Men's Morris <https://en.wikipedia.org/wiki/Nine_men%27s_morris>`_
      - df_nine_mens_morris
      - X
      - 
    * - `Pass the Food <https://www.ludism.org/ppwiki/PassTheFood>`_
      - df_pass_the_food
      - X
      -
    * - `Piece Gaps <https://www.ludism.org/ppwiki/PieceGaps>`_
      - df_piece_gaps
      -
      -
    * - `Piece Packing Pirates <https://www.ludism.org/ppwiki/PiecePackingPirates>`_
      - df_piece_packing_pirates
      -
      -
    * - `Piecepack Klondike <https://www.ludism.org/ppwiki/PiecepackKlondike>`_
      - df_piecepack_klondike
      -
      -
    * - `Piecepackman <https://www.ludism.org/ppwiki/Piecepackman>`_
      - df_piecepackman
      -
      - Currently just the "Roundabout" variant
    * - `Plans of Action <https://www.ludism.org/ppwiki/PlansOfAction>`_
      - df_plans_of_action
      - 
      -
    * - `Quatri <https://www.ludism.org/ppwiki/Quatri>`_
      - df_quatri
      - 
      -
    * - Rect Board Tiles
      - df_rect_board_tiles
      -
      - Makes a rectangular board with tiles
    * - `Relativity <https://www.ludism.org/ppwiki/Relativity>`_
      - df_relativity
      -
      -
    * - `Salta <https://en.wikipedia.org/wiki/Salta_(game)>`_
      - df_salta
      -
      -
    * - `San Andreas <https://www.ludism.org/ppwiki/SanAndreas>`_
      - df_san_andreas
      -
      -
    * - `Shogi (Japanese Chess) <https://www.ludism.org/ppwiki/Shogi>`_
      - df_shogi
      - X
      -
    * - `Skyscrapers <https://www.ludism.org/ppwiki/Skyscrapers>`_
      - df_skyscrapers
      -
      -
    * - `Slides of Action <https://www.ludism.org/ppwiki/SlidesOfAction>`_
      - df_slides_of_action
      -
      -
    * - `Tablut <https://www.ludism.org/ppwiki/Tablut>`_
      - df_tablut
      - X
      -
    * - `The "In" Crowd <https://www.ludism.org/ppwiki/TheInCrowd>`_
      - df_the_in_crowd
      -
      -
    * - `The Magic Bag <https://www.ludism.org/ppwiki/The_Magic_Bag>`_
      - df_the_magic_bag
      -
      -
    * - `Tower of Babel <https://www.ludism.org/ppwiki/TowerOfBabel>`_
      - df_tower_of_babel
      -
      -
    * - `Triactor <https://www.ludism.org/ppwiki/Triactor>`_
      - df_triactor
      -
      -
    * - `Tula <https://www.ludism.org/ppwiki/Tula>`_
      - df_tula
      -
      -
    * - `Turkish Draughts <https://en.wikipedia.org/wiki/Turkish_draughts>`_
      - df_turkish_draughts
      -
      -
    * - `Twelve Men's Morris <https://en.wikipedia.org/wiki/Morabaraba>`_
      - df_twelve_mens_morris
      - X
      - 
    * - `Ultima <https://en.wikipedia.org/wiki/Baroque_chess>`_
      - df_ultima, df_baroque_chess
      -  
      -
    * - `Wormholes <https://www.ludism.org/ppwiki/Wormholes>`_
      - df_wormholes
      -
      -
    * - `Xiangqi (Chinese Chess) <https://www.ludism.org/ppwiki/Xiangqi>`_
      - df_xiangqi
      - X
      -

Contained in tradgames
~~~~~~~~~~~~~~~~~~~~~~

.. list-table:: Game Start Functions contained in tradgames
    :header-rows: 1
    :widths: 30, 30, 40

    * - game
      - df_names
      - comment 
    * - Breakthrough
      - df_breakthrough
      - 
    * - (American) Checkers
      - df_american_checkers
      -
    * - Crossings
      - df_crossings
      - 
    * - Focus
      - df_focus
      -
    * - Four-Field Kono
      - df_four_field_kono
      -
    * - Lines of Action
      - df_lines_of_action
      -
    * - Turkish Draughts
      - df_turkish_draughts
      -




