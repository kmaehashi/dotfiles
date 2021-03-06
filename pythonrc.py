#!/usr/bin/env python
# -*- coding: utf-8 -*-

# modules used frequently
import os
import os.path
import sys
import json

# enable readline
readline = None
rlcompleter = None
try:
    import readline
    import rlcompleter
    readline.parse_and_bind("tab: complete")
except:
    pass
finally:
    del readline
    del rlcompleter
