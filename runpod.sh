#!/bin/bash

# 1) Install uv
curl -L https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env

# 2) Assuming repo is cloned, run setup scripts
bash dotfiles/github.sh
source dotfiles/install.sh

# 3) Clone the current working repo
git clone https://github.com/chry-santhemum/ocr
cd ~/ocr
# uv pip install -r requirements.txt
