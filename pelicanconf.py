#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Trevor L Davis'
SITENAME = u'piecepackr: Piecepack Graphics in R'
SITEURL = 'https://trevorldavis.com/piecepackr'

PATH = 'content'

TIMEZONE = 'America/Los_Angeles'

DEFAULT_LANG = u'en'

THEME = 'notmyidea-tld'
FOOTNOTE = 'Copyright \u00a9 2019 Trevor L Davis.  Some Rights Reserved.<p>Except where otherwise noted content on this site is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.</p>'

STATIC_PATHS = ['images', 'share']

# Blogroll
LINKS = (('piecepackr source', 'https://github.com/trevorld/piecepackr'),
         ("this website's source", "https://github.com/trevorld/piecepackr_site"),
         ('piecepack wiki', 'http://ludism.org/ppwiki/'),
#        ('piecepack BGG page', 'https://boardgamegeek.com/boardgame/2860/piecepack'),
)
GITHUB_URL = "https://github.com/trevorld/piecepackr_site"
# SOCIAL = (('You can add links in your config file', '#'),
#           ('Another social link', '#'),)
FEED_ALL_ATOM = 'feeds/all.atom.xml'
# CATEGORY_FEED_ATOM = 'feeds/{slug}.atom.xml'

DEFAULT_PAGINATION = False
