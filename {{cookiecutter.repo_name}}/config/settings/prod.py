# -*- coding: utf-8 -*-
"""
Production settings
"""

from __future__ import absolute_import, unicode_literals

from .common import *  # noqa

# ------------------------------------------------------------------------------
# STATIC CONFIGURATION
# ------------------------------------------------------------------------------

STATIC_ROOT = str(ROOT_DIR('assets'))

# ------------------------------------------------------------------------------
# SITE CONFIGURATION
# ------------------------------------------------------------------------------

ALLOWED_HOSTS = env.list('DJANGO_ALLOWED_HOSTS', default=['{{cookiecutter.domain_name}}'])
