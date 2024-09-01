#!/bin/bash

#pyenv global system
#pyenv local system
#pyenv install 3.8.19
#pyenv global 3.8.19
#pyenv local 3.8.19

pip3 install torch==1.13.0 torchvision==0.13.0 torchaudio==0.13.0 --index-url https://download.pytorch.org/whl/cpu --verbose
pip3 install pyqt5 --config-settings --confirm-license= --verbose
pip3 install argostranslategui

