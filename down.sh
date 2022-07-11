#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

vagrant destroy -f

sudo rm -rf logs/*.log
