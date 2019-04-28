Piecepackr Companion Website
============================

This is the source code for the `companion website`_ for the piecepackr_ R_ package.  piecepackr_ makes it easy to create customizable piecepack_ graphics for game diagrams, animations, and print-and-play layouts.  This companion website contains documentation and several demos on how to use piecepackr_ (including downloadable print-and-play layouts and configurations).

.. _piecepackr: https://github.com/trevorld/piecepackr

.. _R: https://cran.r-project.org

.. _piecepack: www.ludism.org/ppwiki

.. _companion website: https://trevorldavis.com/piecepackr/

Dependencies
------------

.. code:: bash

   $ sudo apt install python3-pip rake r-base rsync
   $ sudo apt install fonts-dejavu fonts-noto
   $ pip3 install pelican pelican_comment_system Pillow
   $ sudo R

.. code:: r

   install.packages(c("animation", "dplyr", "knitr", "remotes"))
   remotes::install_github("trevorld/piecepackr")

.. code:: bash

   $ fonts_dir=${XDG_DATA_HOME:-$HOME/.local/share}/fonts/
   $ curl -O http://www.quivira-font.com/files/Quivira.otf
   $ mv Quivira.otf $fonts_dir
   $ curl -O https://noto-website-2.storage.googleapis.com/pkgs/NotoEmoji-unhinted.zip
   $ unzip NotoEmoji-unhinted.zip NotoEmoji-Regular.ttf
   $ mv NotoEmoji-Regular.ttf $fonts_dir
   $ rm NotoEmoji-unhinted.zip
   $ sudo mv /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf ~/

Build and deploy website
------------------------

.. code:: bash

   $ rake -T
   rake clean    # Remove any temporary products
   rake clobber  # Remove any generated files
   rake default  # Build website
   rake deploy   # Deploy website to trevor.l.davis.com/piecepackr
   rake test     # Test website on localhost:8000
