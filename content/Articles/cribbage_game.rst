Cribbage
========

:date: 2019-05-16
:tags: piecepack-games
:summary: `Cribbage <{static}/share/rules/cribbage.pdf>`_ is a popular two-person card game that usually requires a special cribbage board to keep score. Below is a diagram of using a piecepack to make an effective cribbage board. 



`Cribbage <{static}/share/rules/cribbage.pdf>`_ is a popular two-person card game that usually requires a special cribbage board to keep score. Below is a diagram of using a piecepack to make an effective cribbage board. 


.. sourcecode:: r
    

    library("grid")
    library("piecepackr")
    library("ppgames")
    cfg <- pp_cfg(list(suit_color="darkred,black,darkgreen,darkblue,black", 
                       border_color="black", border_lex=4))
    pmap_piece(df_cribbage_board(), cfg=cfg, default.units="in")
    grid.draw(textGrob_cribbage_board(cfg$get_suit_color()))

.. figure:: {static}/images/knitr/games-cribbage-starting-diagram-1.png
    :align: center
    :alt: Using a piecepack as a Cribbage Board
    :width: 30%

    Using a piecepack as a Cribbage Board


