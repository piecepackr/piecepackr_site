Piecepackr Companion Website
============================

This is the source code for the `companion website`_ for the piecepackr_ R_ package.  piecepackr_ makes it easy to create customizable piecepack_ graphics for game diagrams, animations, and print-and-play layouts.  This companion website contains documentation and several demos on how to use piecepackr_ (including downloadable print-and-play layouts and configurations).

.. _piecepackr: https://github.com/trevorld/piecepackr

.. _R: https://cran.r-project.org

.. _piecepack: www.ludism.org/ppwiki

.. _companion website: https://trevorldavis.com/piecepackr/

Dependencies
------------

Command-line installation instructions (for Ubuntu):

.. code:: bash

   # pelican blogging system (plus rake)
   sudo apt install python3-pip rake rsync
   pip3 install pelican pelican_comment_system Pillow typogrify

   # some nice fonts
   sudo apt install fonts-dejavu fonts-noto
   fonts_dir=${XDG_DATA_HOME:-$HOME/.local/share}/fonts/
   curl -O http://www.quivira-font.com/files/Quivira.otf
   mv Quivira.otf $fonts_dir
   curl -O https://www.chessvariants.com/d.font/chess1.ttf
   mv chess1.ttf $fonts_dir
   curl -O https://noto-website-2.storage.googleapis.com/pkgs/NotoEmoji-unhinted.zip
   unzip NotoEmoji-unhinted.zip NotoEmoji-Regular.ttf
   mv NotoEmoji-Regular.ttf $fonts_dir
   rm NotoEmoji-unhinted.zip
   sudo mv /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf ~/

   # R plus some R package dependencies
   sudo apt install cabal-install
   cabal update # add $HOME/.cabal/bin to $PATH
   cabal install pandoc

   sudo apt install r-base librsvg2-dev texlive-xetex cargo
   sudo apt install ghostscript imgp libimage-exiftool-perl

R package installation instructions (start R with ``R``):

.. code:: r

   install.packages(c("remotes", "ragg", "rgl", "rsvg"))
   remotes::install_github("piecepackr/piecepackr")
   piecepackr::install_ppverse()
   remotes::install_github("piecepackr/piecenikr")
   remotes::install_github("trevorld/r-xmpdf")
   remotes::install_github("trevorld/sbgjackets")
   quit("no")


Build and deploy website
------------------------

.. code:: bash

   $ rake -T
   rake clean    # Remove any temporary products
   rake clobber  # Remove any generated files
   rake default  # Build website
   rake deploy   # Deploy website to trevor.l.davis.com/piecepackr
   rake test     # Test website on localhost:8000
