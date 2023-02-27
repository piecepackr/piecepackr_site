#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Trevor L Davis'
SITENAME = u'piecepackr: Board game graphics'
SITEURL = 'https://trevorldavis.com/piecepackr'

FAVICON_IMG = 'https://trevorldavis.com/share/piecepack/favicon.ico'

PATH = 'content'

TIMEZONE = 'America/Los_Angeles'

DEFAULT_DATE_FORMAT = '%Y-%m-%d'
DEFAULT_LANG = u'en'

THEME = 'notmyidea-tld'

FOOTNOTE = 'Copyright \u00a9 2019&ndash;2023 Trevor L Davis.  Some Rights Reserved.<p>Except where otherwise noted content on this site is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.</p>'

STATIC_PATHS = ('images', 'share')

TYPOGRIFY = True
TYPOGRIFY_DASHES = 'oldschool'

# Blogroll
LINKS = (("piecepackr's source", 'https://github.com/piecepackr'),
         ('piecepack wiki', 'http://ludism.org/ppwiki'),
#        ('piecepack BGG page', 'https://boardgamegeek.com/boardgame/2860/piecepack'),
)
# GITHUB_URL = "https://github.com/trevorld/piecepackr_site"
# SOCIAL = (('You can add links in your config file', '#'),
#           ('Another social link', '#'),)
FEED_ALL_ATOM = 'feeds/all.atom.xml'
TAG_FEED_ATOM = 'feeds/{slug}.atom.xml'
# CATEGORY_FEED_ATOM = 'feeds/{slug}.atom.xml'

DEFAULT_PAGINATION = False # Use a number to restrict number of elements in "page"

# PLUGINS = ['pelican_comment_system']
PELICAN_COMMENT_SYSTEM = True
PELICAN_COMMENT_SYSTEM_IDENTICON_DATA = ('author',)
PELICAN_COMMENT_SYSTEM_EMAIL_USER = 'piecepackr'
PELICAN_COMMENT_SYSTEM_EMAIL_DOMAIN = 'trevorldavis.com'
PELICAN_COMMENT_SYSTEM_FEED = None
PELICAN_COMMENT_SYSTEM_FEED_ALL = 'feeds/comments.all.atom.xml'
