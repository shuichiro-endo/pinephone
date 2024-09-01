# pinephone
pinephone

## install Two-Boot
- Two-Boot Installation instructions
    - Installing to eMMC Boot (recommended)
        - [https://tow-boot.org/devices/pine64-pinephoneA64.html](https://tow-boot.org/devices/pine64-pinephoneA64.html)
        - [https://github.com/Tow-Boot/Tow-Boot/releases](https://github.com/Tow-Boot/Tow-Boot/releases)

## install Mobian Phosh
- [https://images.mobian-project.org/pinephone/installer/weekly/](https://images.mobian-project.org/pinephone/installer/weekly/)

## setup
### install nftables

### install openssh-server

### change scale setting (200 -> 100)
1. modify /usr/share/phosh/phoc.ini file
    ```
    #[core]
    #xwayland=false

    [output:DSI-1]
    #scale = 2
    scale = 1

    [output:Virtual-1]
    # For the x86 VM using QXL to get a phone like geometry
    modeline = 87.25  720 776 848 976  1440 1443 1453 1493 -hsync +vsync
    mode = 720x1440
    #scale = 2
    scale = 1

    [output:X11-1]
    #mode = 360x720
    mode = 720x1440
    #rotate = 90
    scale = 1

    [output:WL-1]
    #mode = 360x720
    mode = 720x1440
    #rotate = 90
    scale = 1

    [output:HEADLESS-1]
    mode = 720x1440
    #rotate = 90
    #scale = 2
    scale = 1
    ```
2. reboot pinephone

### install japanese input method
1. install gnome tweaks
    ```
    sudo apt update
    sudo apt upgrade -y
    sudo apt gnome-tweaks
    ```
2. install fcitx5-kkc
    ```
    sudo apt install fcitx5-kkc
    ```
3. add the following variables to ~/.profile file 
    - ~/.profile
    ```
    # fcitx5
    export XMODIFIERS=@im=fcitx
    export QT_IM_MODULE=fcitx
    export GTK_IM_MODULE=fcitx
    ```
4. reboot pinephone
5. run Fcitx 5 Configuration application
6. add Kana Kanji to Current Input Method
7. run Tweaks application
8. add Fcitx 5 to Startup Applications
9. reboot pinephone

### install custom squeekboard layout
- [Ick/Squeekboard-Layouts](https://codeberg.org/Ick/Squeekboard-Layouts)
    - Manual Install

### install pyenv
- [pyenv](https://github.com/pyenv/pyenv)

### install argos translate gui
- [argos-translate](https://github.com/argosopentech/argos-translate)
- [argos-translate-gui](https://github.com/argosopentech/argos-translate-gui)

#### install argos translate gui
1. Turn off suspend setting
    - Settings > Power > Automatic Suspend > Never 
1. plug in pinephone
2. install python 3.8.19 using pyenv
    ```
    pyenv global system
    pyenv local system

    pyenv install 3.8.19
    
    pyenv global 3.8.19
    pyenv local 3.8.19
    ```
3. run install_argostranslategui.sh
    > [!CAUTION]
    > In the case of pinephone, this installation takes about 6 hours.
    >
    > In some cases, it takes longer than that.
    - install_argostranslategui.sh
    ```
    #!/bin/bash

    pip3 install torch==1.13.0 torchvision==0.13.0 torchaudio==0.13.0 --index-url https://download.pytorch.org/whl/cpu --verbose
    pip3 install pyqt5 --config-settings --confirm-license= --verbose
    pip3 install argostranslategui
    ```
    - pyenv version
    ```
    $ pyenv versions
      system
    * 3.8.19 (set by /home/test/.python-version)
    ```
    - pip list
    ```
    $ pip list
    Package            Version
    ------------------ ---------
    argostranslate     1.9.6
    argostranslategui  1.6.5
    certifi            2022.12.7
    charset-normalizer 2.1.1
    click              8.1.7
    ctranslate2        4.3.1
    idna               3.4
    joblib             1.4.2
    numpy              1.24.4
    packaging          24.1
    pillow             10.2.0
    pip                23.0.1
    protobuf           5.28.0
    PyQt5              5.15.11
    PyQt5_sip          12.15.0
    PyYAML             6.0.2
    regex              2024.7.24
    requests           2.28.1
    sacremoses         0.0.53
    sentencepiece      0.2.0
    setuptools         56.0.0
    six                1.16.0
    stanza             1.1.1
    torch              1.13.0
    torchaudio         0.13.0
    torchvision        0.13.0
    tqdm               4.66.5
    typing_extensions  4.9.0
    urllib3            1.26.13

    [notice] A new release of pip is available: 23.0.1 -> 24.2
    [notice] To update, run: pip install --upgrade pip
    ```
4. run argostranslategui (performance test)
    > [!NOTE]
    > To perform a translation, you need to download the language packages data using Manage Packages.
    >
    > The size of the language packages data is approximately 11GB (~/.local/share/argos-translate/packages directory).
5. create argostranslategui.desktop file
    - ~/.local/share/applications/argostranslategui.desktop
    ```
    #!/usr/bin/env python3
    [Desktop Entry]
    Version=1.0
    Type=Application
    Terminal=false
    Exec=/home/mobian/.pyenv/shims/argos-translate-gui      # change username (mobian)
    Name=argos-translate-gui
    Comment=argos translate gui
    Icon=                                                   # optional
    Categories=Utility;
    ```
6. run argostranslategui application (performance test)

#### change font size of argos translate gui
1. modify ~/.pyenv/versions/3.8.19/lib/python3.8/site-packages/argostranslategui/gui.py
   
   [https://github.com/argosopentech/argos-translate-gui/blob/main/argostranslategui/gui.py#L344](https://github.com/argosopentech/argos-translate-gui/blob/main/argostranslategui/gui.py#L344)
    ```
    # TextEdits
    self.left_textEdit = QTextEdit()
    self.left_textEdit.setPlainText("Text to translate from")

    self.left_textEdit.setFont(QFont('Arial', 24))              # add

    self.left_textEdit.textChanged.connect(self.translate)
    self.right_textEdit = QTextEdit()

    self.right_textEdit.setFont(QFont('Arial', 24))             # add

    self.right_textEdit.setPlainText("Text to translate to")
    self.textEdit_layout = QHBoxLayout()
    self.textEdit_layout.addWidget(self.left_textEdit)
    self.textEdit_layout.addWidget(self.right_textEdit)
    ```
2. run argostranslategui application (performance test)
![](imgs/001.jpg)

