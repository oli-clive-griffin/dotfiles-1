#!/bin/bash

# 1) Install packages
apt-get update
apt-get install -y tmux

# 2) Add aliases and environment variables to .bashrc
echo "alias gc='git add . && git commit -m'" >> /root/.bashrc
echo "alias tma='tmux attach -t'" >> /root/.bashrc
echo "alias venv='source /root/.venv/bin/activate'" >> /root/.bashrc

echo "export HF_HOME=/workspace/hf" >> /root/.bashrc
echo "export HF_HUB_ENABLE_HF_TRANSFER=1" >> /root/.bashrc

source /root/.bashrc

# 3) Set up huggingface cache at /workspace/hf

source .venv/bin/activate
uv add "huggingface_hub[cli]" --active
uv add "huggingface-hub[hf-transfer]" --active
uv add "wandb" --active

huggingface-cli login --token $RUNPOD_HF_TOKEN --add-to-git-credential
wandb login $RUNPOD_WANDB_TOKEN

# 4) Install ipykernel
uv add --dev ipykernel --force-reinstall --active
uv run ipython kernel install --env VIRTUAL_ENV ~/.venv --name=project
uv run --with jupyter jupyter lab
