#!/bin/bash
#+-----------------------------------------------------------+
#|                                                           |
#| Lib for URL manipulation                                  |
#|                                                           |
#+-----------------------------------------------------------+
#| version : VERSION_SCRIPT                                  |
#+-----------------------------------------------------------+

URL0=`echo $SITE_URLS | sed 's|,.*||g' | sed "s|'||g"`
HOST0=`echo $URL0 | sed 's|http[s]*://||g' |sed 's|/.*||g'`
URL_ALIAS=`echo $SITE_URLS | sed 's|,| |g' | sed 's|http[s]*://||g'`
URL_SETTING=`echo $URL_ALIAS | sed 's|/|\.|g'`
