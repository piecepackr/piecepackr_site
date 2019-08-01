Portable Piecepack Notation
===========================

:Date: 2019-08-01

**Version: 0.2**

The Portable Piecepack Notation (ppn) is a human-readable plaintext file format for storing board games.  The default Movetext parser is designed to be provide a fairly flexible notation system out of the box for playing a large variety of piecepack games but the structure is designed to in the future allow support for parsing alternative notation systems as well.  There is a prototype parser for this file format written in R that can be used to generate images, plaintext Unicode diagrams, and animations for the games saved in this file format.

.. warning:: The "Portable Piecepack Notation" is in alpha development and the specification is not likely to remain stable.  I'd appreciate alpha testers to test things out but probably not a good idea to start storing large amount of games in the format just yet.

.. _PBN: http://www.tistis.nl/pbn/
.. _PDN: http://pdn.fmjd.org/
.. _PGN: http://www.saremba.de/chessgml/standards/pgn/pgn-complete.htm
.. _PSN: http://genedavis.com/articles/2014/05/09/psn/
.. _YAML: https://yaml.org/

.. contents::


Examples
--------

A simple game of Tic-Tac-Toe with no automatic setup::

    ---
    Event: Example Tic-Tac-Toe Game
    Result: 1-0
    ...
    setup. t@b2
    1. S@b2 1... M@a2 {? (1... M@a1)}
    2. S@c1 2... M@a3
    3. S@a1 3... M@c3
    4. S@b1 {X wins}

A game of Four Field Kono with automatic setup::

    GameType: Four Field Kono

    1. b1:b3 1... d3:b3 2. c1:c3 2... a3:c3 3. c2-c1 3... b4:b2 4. a1-b1 4... b3:b1
    5. d1:b1 5... c3-c2 6. a2-a3 6... b2:d2 7. a3-b3 7... c4-c3 8. c1-d1 8... d4-d3
    9. b1-b2 9... d2:b2 10. b3-a3 10... b2-b1 {Player 1's loss is assured with the
     separation of their two remaining pieces and they should resign in a real game}
    11. a3-a2 11... b1-c1 12. d1-d2 12... c1-d1 13. a2-a3 13... a4-b4
    14. a3-a4 14... b4-c4 15. a4-b4 15... c4-d4 16. b4-a4 16... d4:d2 {Player 2 wins}

.. image:: https://www.trevorldavis.com/share/piecepack/four_field_kono_example.gif
    :alt: Four Field Kono example

PPN File Structure
------------------

PPN files are text files ending in ``.ppn`` containing one or more games in PPN notation.

* Each game in the file should start with a line beginning with ``---``.  
  
  + This line is recommended but optional for the first game in a PPN file. If the first game in each PPN file begins with a ``---`` then one can build larger PPN file archives by simply concatenating smaller PPN files together (i.e. with the \*nix ``cat`` command).

* Each game starts with a Metadata_ section and ends with a Movetext_ section.
* PPN files should be assumed to use an UTF-8 character encoding (this includes ASCII) with no maximum line length.

Metadata
~~~~~~~~

* The Metadata section should be a single "Mapping" expressed in YAML_.

  + It is recommended to use the subset of YAML_ understood by both the 1.1 and 1.2 YAML_ standards since not all popular parsers understand both (or just YAML_ 1.2).

* It should begin with a line starting with ``---``.
 
  + This is the same ``---`` we said begins each game.
  + The ``---`` is recommended but optional for the first game in a PPN file.

* It should end with a line starting with ``...``.

  + This ``...`` is recommended but optional if the Metadata section does not have any empty lines and there is at least one empty line between the Metadata and Movetext_ sections.
  + If there are no lines starting with ``...`` and no empty lines the Metadata section should be assumed to be empty.

* All Metadata keys are optional.
  
  + If the Metadata section is empty PPN parsers should use the default Movetext parser described in a later section to interpret the Movetext_ (without doing any initial game piece setup).


Movetext
~~~~~~~~

* Regardless of the Movetext parser to be used the Movetext should not have any lines *starting* with ``---`` or ``...``.
* Should be (initially) parsed as UTF-8 text without restrictions on line length.
* Additional restrictions based on which Movetext parser is used to parse it.  The default Movetext parser and its additional restrictions will be described in a later section.

To implement in the future?
~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Allow the PPN parser to use a Movetext parser different from the default one by setting the ``MovetextFn`` key (or perhaps better ``MovetextParser``?) with a string indicating the parser to use.
* Support PGN_-style "Tag Pair" syntax as an alternate way to express a key/pair in the Metadata_ "Mapping".  
* Make recommendations about which key/value pairs to use in the Metadata_ section and more standard ways to express them.

  + "Event", "Site", "Date", "Result" are consistently found in PGN_-derived notations such as PBN_, PDN_, and PSN_ (although the interpretation for "Result" differs) whereas "White", "Black", and "Round" are not (for example PBN_ uses"West", "North", "East", "South").  "Setup" also seems a good candidate to make recommendations about (and PPN exporters should explicitly setup boards with random starts since "seeds" may not be portable across programming languages).  PGN_ distinguishes between "no value" with "-" (i.e. no title, no ELO rating, etc.) and "unknown value" with "?".  "Date" seems to be interpreted as the start date for games that take more than one day to play.

Default Movetext Parser
-----------------------

* The default Movetext Parser will supports automatic Setup_ for various piecepack games via the Metadata_ mapping.


* The default Movetext Parser supports the following Movetext elements: 
  
  1. Comments_
  2. MoveNumbers_
  3. Moves_

* Each element needs to be separated from other elements by whitespace 

  + Whitespace is defined as tabs, newlines, form feeds, and any character in the Unicode Z Category.
  + All whitespace between elements (and in comments) will be converted to single spaces.

* The default parser keeps track of the (x,y) coordinates of pieces and an ordering they can be placed on the board to reproduce the state of the board after that move.  For convenience we will sometimes refer to pieces placed on the board later (earlier) in this ordering as being placed "above" ("beneath") those placed earlier (later) in this ordering, please note however that in real life a high stack of pieces placed earlier may physically be "above" an adjacent single piece placed later.

Setup
~~~~~

* Currently the Movetext Parser uses the ``GameType`` field in the Metadata_ to provide game setup.  This value should be a string with the game's name.

  + Although in general tags will treated case sensitive in this case we first process the string by converting to lower case, removing apostrophes, "squishing" the whitespace, and converting spaces to underscores e.g. "Nine Men's Morris" will be treated as equivalent to "nine_mens_morris".  Occasionally we will provide aliases e.g. "Baroque chess" will be treated as an alias for "Ultima".

Comments
~~~~~~~~

* Comments are any text between braces ``{`` and ``}``

  + All whitespace will be parsed as single spaces, in particular comments can span multiple lines
  + Braces are not allowed within comment braces

MoveNumbers
~~~~~~~~~~~

* MoveNumbers are at least one letter, number, and/or underscore ``_`` followed by at least one period ``.``.

  + MoveNumbers are optional but if they exist PPN parsers will often break down and label moves by MoveNumbers (i.e. to make animations of a game)

Moves
~~~~~

* Moves are comprised of Piece_, Location_, and MoveToken_.

Piece
~~~~~

* The default Movetext parser supports Simplified_ piecepack piece notation

Simplified
++++++++++

* Pieces: t, c, d, p

  + If missing assumed to be a tile if has both suit and rank or neither suit and rank otherwise assumed to be a coin.

* Side Up: f, b

  + If missing tiles are assumed to be "back" up if missing suit and/or rank.
  + If missing coins are assumed to be "face" up if missing suit.
  + If missing pawns and dice are assumed to be "face" up (and only pawns can be "back" up).

* Suits: S, M, C, A

  + If missing assumed to be "Suns" for tile faces, coin backs, pawns, and dice.

* Ranks: n, a, 2, 3, 4, 5

  + If missing assumed to be "null" for tile faces, coin faces, and dice.

* Direction: ^, <, >, v

  + If missing direction should be assumed to be straight up

* Ordering of elements should not matter but the following ordering may improve readability (omitting any unnecessary elements as necessary):

  1. Piece
  2. Side up
  3. Suit
  4. Rank
  5. Direction

* Simplified piecepack piece notation does not support angles that aren't a multiple of 90 degrees nor 3D tilts
* Simplified piecepack piece notation does not support piecepack expansions / accessories or other game systems

Examples:

* ``t`` tile back
* ``Aa>`` ace of Arms tile (face) oriented "right"
* ``C`` Crowns coin back (oriented "up")
* ``cC3b^`` (3 of) Crowns coin back (explicitly) oriented "up"
* ``nv`` null coin face oriented "down"
* ``<dM4`` 4 of Moons die oriented "left"
* ``d`` (null of Suns) dice
* ``pM`` Moons pawn
* ``p`` (Suns) pawn

Location
~~~~~~~~

* The default Movetext parser supports locations either by its Cartesian coordinates or chess-algebraic-style coordinates

Examples:

* (2.5,3.5)
* (3,2)
* c2 

Cartesian coordinates
+++++++++++++++++++++

* Cartesian coordinates are a left parenthesis followed by a digits (including up to one period) followed by a comma followed by digits (including up to one period) ending in a right parenthesis.

  + The digits will be considered to be a "floating-point" number.
  + The number left of the comma will be the x-coordinate and the number right of the comma the y-coordinate.

Chess-algebraic-style coordinates
+++++++++++++++++++++++++++++++++

* Chess-algebraic-style coordinates begin with lowercase letters followed by digits. 
* The lowercase letters are considered to be the x-coordinate encoded as a base-26 number using the Roman letters as numerals.

  + For the purposes of this there is no "zero".  ``a`` is considered equal to 1, ``z`` is considered equal to 26, and ``aa`` is considered equal to 27.

* The digits are considered to the y-coordinate encoded as a (base-10) integer.

MoveToken
~~~~~~~~~

The default movetext parser supports the following MoveTokens:

* ``@`` is used to add pieces to the board.  ``Piece@Location`` means drop Piece_ on top of Location_.

  + It will be placed after all other pieces in the internal ordering.

* ``*`` is used to remove pieces from the board.  ``*Location`` means remove the top piece at Location_.

  + Unlike other MoveTokens it can be added at the end of other Moves e.g. ``b5-c5*b4*b3 {Move top piece at b5 to c5 and remove top pieces at b4 and b3}``.

* ``-`` is used to move pieces elsewhere on the board.  ``Location1-Location2`` means removing the top piece at Location1 and dropping it on top of Location2.

  + It will be placed after all the other pieces in the internal ordering.

* ``:`` is used to represent a "displacement capture".  ``Location1:Location2`` means removing the top piece from Location2, then removing the top from Location1 and putting it on top of Location2.

  + The piece moved from Location1 to Location2 will be placed after all the other pieces in the internal ordering.
  + ``Location1:Location2`` is equivalent to ``*Location2 Location1-Location2``.

To implement in the future?
~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Allow the dropping of pieces "beneath" other pieces.  Perhaps use ````` for this?  Example::

   A3`b4 {Place a three of Arms tile face under any pieces at b4}

* Allow the moving of pieces "beneath" other pieces.  Perhaps use ``\`` for this?  Example::

    b2\b4 {Move the top piece from b2 under any pieces at b4}

* Allow specifying specific pieces within a location to move or remove:

  + Tak-style number prefix e.g. ``2b4-b3*2a2 {Move top two pieces at b4 to b3 and remove top two pieces at a2}``
  + Array-slicing style suffixes.  Examples::

      b4[0:1]-b3*a2[0:1] {move top two pieces at b4 to b3 and remove top two pieces at a2}
      *b4[$] {Remove last piece at b4}
      *b4[*] {Remove all pieces at b4}

    - Index starting with zero?  Use as shortcuts ``*`` for all and ``$`` for last+

* When moving pieces on top (or beneath) a location instead of putting all the way on top (or beneath) allow specifying the exact piece to place after (or before) in the internal piece ordering by enclosing in ``<>`` examples::

    C@b3<b3[1]> {Place a Crowns coin back right above the second piece at b3 (and hence under the top piece)}
    C@b3<b2[$]> {Place a Crowns coin back right "after" the bottom piece at b2 (i.e. a tile) in the internal ordering}
    b4[3]-b5<b5[2]> {Move the 4th piece at b4 to b5 right above the 3rd piece}

  - Index starting with zero?
  - Allow array specification as shortcut for where to place a piece e.g. ``b2@b5[2]`` as shortcut for ``b2@b5<b5[2]>``?

* Allow replacing pieces with ``=``.  Example::

   b5=S> {replace top piece at b5 with Suns coin back oriented right}
   
  + Further allow at end of move i.e. ``b7-b8=4``.

* Implement Bash-style brace expansions.  Examples::

    t@{b,d}{2..8..2} {Shortcut for t@b2 t@b4 t@b6 t@b8 t@d2 t@d4 t@d6 t@d8}
    *{b..f}2 {Shortcut for *b2 *c2 *d2 *e2 *f2}

  + Don't allow nesting brace expansions
  + Unlike Bash-style brace expansions must have a "preamble" or "postscript" otherwise will be interpreted as a comment (but the preamble or postscript can be another brace expansion)

* Allow flipping pieces over with ``+``.  Example (assuming brace expansion support)::

    S@a3 b{3..7}+ {Put Suns coin back at a3 then flip over top pieces from b3 to b7}

* Allow specifying which pieces to move or remove by piece info instead of location.  
  
  + Perhaps use a variant of Simplified_ piece notation but require all elements in the recommended ordering with ``.`` as a wildcard.  Examples::

     *cb... {Remove all coin backs from board}
     *..S.. {Remove all the Suns pieces from board}
     cf2..-b3 {Move all 2-valued coin-faces to b3}
     5@c.A2. {Put a 5-valued coin on top of the 2 of Arms coin}

* Allow expressing macros in Metadata_ section for pieces and/or locations

  + Parse first (converting to normal Piece/Location notation) and then parse normally
  + Allow even more flexibility by allowing specification of functions to automatically adjust location/piece i.e. a function to automatically generate hexagonal coordinates?

* Implement a more flexible "Complex" piece notation that can support adding pieces from other game systems and non-90 degree rotations

  + Especially valuable if combined with macros since players wouldn't necessarily need to use this notation in their games

  + Perhaps start with ``piece_side`` and/or piece specification from Simplified_ notation followed by a ``;`` and then (optionally) specify:
   
    - suit with ``s#;`` (``#`` a number starting from 0)
    - rank with ``r#;`` (``#`` a number starting with 0)
    - angle with ``a#;`` (``#`` degrees)
    - reserve ``x#;`` and ``y#;`` for possible expressing 3d-tilt in far future
    - put game system at end (default assume piecepack)
      
      + can contain letters numbers and underscore but can't be a single character plus number

    Examples::

       tile_back
       5;a45 {5-valued coin angled 45 degrees}
       tf;r5;s0;playing_card_expansion {5 of Hearts tile face}
       pyramid_top;s0;r2;icehouse_pyramids {two-pipped red icehouse pyramid}
       tf;s0;r3;a90;blue_dominoes {a blue null-3 blue domino rotated 90-degrees}

* Allow rotating pieces (other than with ``=`` notation).  Perhaps use ``>`` and ``<``?::

    b4> {Rotate piece at b4 90 degrees to the right}
    b4>> {Rotate piece at b4 180 degrees}

  + Allow at end of a move?


