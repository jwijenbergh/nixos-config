#!/usr/bin/env bash
appres "$1" | grep "\.$2" | cut -d ":" -f2 | tr -d '\t'
