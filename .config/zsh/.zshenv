# XDG base folders
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME="$HOME"/.cache

export ZSH_HOME="$XDG_CONFIG_HOME"/zsh
export DEV_FOLDER="$HOME"/Dev
export PROGRAMS_FOLDER="$HOME"/Programs

# Setup PATH
LOCAL_SCRIPTS_PATH=":$HOME/.local/bin"
FLUTTER_PATH=":$DEV_FOLDER/Libraries/flutter/bin"
ANDROID_PLATFORM_TOOLS_PATH=":$DEV_FOLDER/Libraries/AndroidSdk/platform-tools"
ANDROID_EMULATOR_PATH=":$DEV_FOLDER/Libraries/AndroidSdk/emulator"
ANDROID_TOOLS_PATH=":$DEV_FOLDER/Libraries/AndroidSdk/tools"
ANDROID_TOOLS_BIN_PATH=":$DEV_FOLDER/Libraries/AndroidSdk/tools/bin"
KOTLINC_PATH=":$PROGRAMS_FOLDER/kotlinc/bin"
GO_PATH=":/usr/local/go/bin"

export PATH="$PATH$LOCAL_SCRIPTS_PATH$FLUTTER_PATH$ANDROID_PLATFORM_TOOLS_PATH$ANDROID_EMULATOR_PATH$ANDROID_TOOLS_PATH$ANDROID_TOOLS_BIN_PATH$GO_PATH$KOTLINC_PATH"

# export GTK_THEME=Orchis-Dark
export GTK_THEME=Catppuccin-Mocha-Standard-Mauve-Dark

# Flutter wants to know about Chrome
export CHROME_EXECUTABLE=/usr/bin/chromium

# ANDROID SHIII
export ANDROID_HOME="$DEV_FOLDER/Libraries/AndroidSdk"
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android

# JRE location (Android studio)
export JAVA_HOME="$PROGRAMS_FOLDER/android-studio-canary/jbr"

# Firefox on Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi

# Rust (for XDG)
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# Ruby (for XDG)
export BUNDLE_USER_HOME="$XDG_DATA_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export RBENV_ROOT="$XDG_DATA_HOME"/rbenv

# Java (for XDG)
# export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# Gradle (for XDG)
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

# GnuPG (for XDG)
export GNUPGHOME="$XDG_DATA_HOME"/gnupg