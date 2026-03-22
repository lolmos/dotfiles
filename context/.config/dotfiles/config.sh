#!/bin/sh
# Context configuration — single source of truth for environment detection.
#
# Add hostname patterns as grep -qiE regex patterns.
# Detection priority: manual override > prod > remote > local

# Hostname patterns that indicate production
DOTFILES_PROD_PATTERNS="prod|production"

# Hostname patterns that indicate staging (future use)
# DOTFILES_STAGING_PATTERNS="staging|stg"
