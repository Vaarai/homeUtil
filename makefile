SHELL := /usr/bin/zsh
USER := /home/vaarai
PLUGINS_NAME := zsh-autosuggestions zsh-syntax-highlighting
THEME := crunch

all: 	install_ohmyzsh \
		setup_zshrc \
		clean \


help:
	@echo
	@echo install_ohmyzsh
	@echo setup_zshrc
	@echo remove_config
	@echo


install_ohmyzsh:
	curl -L -o ohmyzsh_install.sh https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	sed -i 's/env zsh -l/return/g' ./ohmyzsh_install.sh
	chmod +x ohmyzsh_install.sh
	source ./ohmyzsh_install.sh

setup_zshrc:
	sed -i "s/^ZSH_THEME=.*/ZSH_THEME='crunch'/g" $(USER)/.zshrc
	for PLUGIN in $(PLUGINS_NAME); do \
		git clone https://github.com/zsh-users/$$PLUGIN $$USER/.zsh/plugins/$$PLUGIN;\
	done; \
	echo "\n\n#CUSTOM PLUGINS\n" >> $(USER)/.zshrc
	for PLUGIN in $(PLUGINS_NAME); do \
		echo source $$USER/.zsh/plugins/$$PLUGIN/$$PLUGIN.zsh >> $$USER/.zshrc;\
	done; \
	echo "\n\n#CUSTOM ALIAS\n" >> $(USER)/.zshrc
	cat ./.zshalias >> $(USER)/.zshrc
	source $(USER)/.zshrc

remove_config:
	rm -rf ~/.zshrc ~/.zsh ~/.oh-my-zsh ~/.zshrc.pre-oh-my-zsh

clean: 
	rm ohmyzsh_install.sh