Chinese Zodiac ranked piecepack PnP
===================================

:date: 2019-06-23
:modified: 2023-02-16
:tags: print-and-play
:summary: The orthodox_ piecepack ranks are a tad abstract and my toddler son is Chinese-American so I think a `Chinese Zodiac`_ ranked piecepack could be a design that is a little more approachable for my son.  The `Chinese Zodiac`_'s 12 animals are divided into 4 trines so we'll make a piecepack using all the animals from two of the trines as ranks and another piecepack using the remaining animals from the other two trines as ranks.  For suits we'll use the `Five Elements`_: Wood, Fire, Earth, Metal, and Water.



.. include:: ../../links.rst

.. _Chinese Zodiac: https://en.wikipedia.org/wiki/Chinese_zodiac
.. _Five Elements: https://en.wikipedia.org/wiki/Wu_Xing

.. _zodiac_cn1:

The orthodox_ piecepack ranks are a tad abstract and my toddler son is Chinese-American so I think a `Chinese Zodiac`_ ranked piecepack could be a design that is a little more approachable for my son.  The `Chinese Zodiac`_'s 12 animals are divided into 4 trines so we'll make a piecepack using all the animals from two of the trines as ranks and another piecepack using the remaining animals from the other two trines as ranks.  For suits we'll use the `Five Elements`_: Wood, Fire, Earth, Metal, and Water.


.. sourcecode:: r
    

    library("piecepackr")
    zodiac_cn1 <- list(rank_text = "🐀,🐉,🐒,🐂,🐍,🐓",
          suit_text = "🌲,🔥,⛰️,🏆,🌊,",
          rank_fontfamily = "Noto Emoji",
          suit_fontfamily = "Noto Emoji,Noto Emoji,Noto Emoji,Noto Sans Symbols2,Noto Emoji",
          rank_cex = 0.6, suit_cex = "0.6,0.5,0.6,0.6,0.5",
          suit_color = "darkgreen,red3,chocolate4,black,darkblue,grey")
    noto_credit <- c("\u25cf This piecepack uses characters from Google Noto Fonts. OFL 1.1.",
                     "\thttps://www.google.com/get/noto/")
    zodiac_cn1$credit <- noto_credit
    zodiac_cn1$description <- c('This piecepack uses ranks and suits from the Chinese Zodiac')
    zodiac_cn1$title <- "Chinese Zodiac (Trines 1+2)"
    if (packageVersion("piecepackr") >= "1.10.0-8") {
        zodiac_cn1$copyright <- "\u00a9 2019 Trevor L Davis.  Some Rights Reserved."
        zodiac_cn1$spdx_id <- "CC-BY-SA-4.0"
    }
    borders <- list(border_lex=4, border_color="black")
    bleed <- list(border_lex=0, border_color=NA_character_)
    zodiac_cn1_cutlines <- pp_cfg(zodiac_cn1)
    zodiac_cn1_borders <- pp_cfg(c(borders, zodiac_cn1))
    zodiac_cn1_bleed <- pp_cfg(c(bleed, zodiac_cn1))
    grid.piece("preview_layout", cfg=zodiac_cn1_cutlines)

.. figure:: {static}/images/knitr/demos-CZ-CZ1-1.png
    :align: center
    :alt: Chinese Zodiac ranked piecepack (Trines 1 and 2)
    :width: 60%

    Chinese Zodiac ranked piecepack (Trines 1 and 2)

.. _zodiac_cn2:


.. sourcecode:: r
    

    zodiac_cn2 <- as.list(zodiac_cn1)
    zodiac_cn2$rank_text <- "🐅,🐎,🐕,🐇,🐏,🐖"
    zodiac_cn2$title <- "Chinese Zodiac (Trines 3+4)"
    zodiac_cn2_cutlines <- pp_cfg(zodiac_cn2)
    zodiac_cn2_borders <- pp_cfg(c(borders, zodiac_cn2))
    zodiac_cn2_bleed <- pp_cfg(c(bleed, zodiac_cn2))
    grid.piece("preview_layout", cfg=zodiac_cn2_cutlines)

.. figure:: {static}/images/knitr/demos-CZ-CZ2-1.png
    :align: center
    :alt: Chinese Zodiac ranked piecepack (Trines 3 and 4)
    :width: 60%

    Chinese Zodiac ranked piecepack (Trines 3 and 4)



