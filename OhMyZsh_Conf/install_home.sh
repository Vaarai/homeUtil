#!/bin/zsh


### SETTINGS ###

PLUGINS_NAME=("zsh-autosuggestions" "zsh-syntax-highlighting")
THEME="crunch"

INSTALL_CANTA="false"  # (true / false)  See https://github.com/Vaarai/Canta-theme for more info



### DO NOT EDIT UNDER THIS LINE IF YOU DON'T KNOW WHAT IT MEAN ###

SHELL="/usr/bin/zsh"
USER_HOME="/home/"$USER

ZSH_install_ohmyzsh () {
	curl -L -o ohmyzsh_install.sh https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	sed -i 's/env zsh -l/return/g' ./ohmyzsh_install.sh
	chmod +x ohmyzsh_install.sh
	source ./ohmyzsh_install.sh
}

ZSH_setup_zshrc () {
	sed -i "s/^ZSH_THEME=.*/ZSH_THEME='$THEME'/g" $USER_HOME/.zshrc
	echo $'\n\n#CUSTOM PLUGINS\n' >> $USER_HOME/.zshrc
	for PLUGIN in ${PLUGINS_NAME[@]}; do \
		git clone https://github.com/zsh-users/$PLUGIN $USER_HOME/.zsh/plugins/$PLUGIN;\
		echo source $USER_HOME/.zsh/plugins/$PLUGIN/$PLUGIN.zsh >> $USER_HOME/.zshrc;\
	done; \
	echo $'\n\n#CUSTOM ALIAS\n' >> $USER_HOME/.zshrc
	cat ./.zshalias >> $USER_HOME/.zshrc
	source $USER_HOME/.zshrc
}

ZSH_remove_config () {
	rm -rf ~/.zshrc ~/.zsh ~/.oh-my-zsh ~/.zshrc.pre-oh-my-zsh
}

THEME_install_mycanta () {
	git clone https://github.com/Vaarai/Canta-theme.git
	cd ./Canta-theme
	./parse-sass.sh
	./render-assets.sh gtk2-dark
	./install.sh -c dark -s compact -r square
	xfconf-query -c xsettings -p /Net/ThemeName -s "Mod-Canta-dark-compact-square"
	cd ..
}

main () {
	if $INSTALL_CANTA = "true"; then
		THEME_install_mycanta
	fi
	ZSH_remove_config
	ZSH_install_ohmyzsh
	ZSH_setup_zshrc
}

main