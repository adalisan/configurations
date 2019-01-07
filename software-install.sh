#!/usr/bin/env bash
set -e

printf "Installing recommended softwares...\n"

# Updating apt to refresh repos
sudo apt-get update

globals=(
	build-essential
  libssl-dev
  pkg-config
  default-jre
  default-jdk
  tree
  mongodb-org
  python-setuptools
  python-pip
  htop
  neofetch
  python-pipenv
  cookiecutter
  golang-go
)

# Install apt modules
function apt-install() {
  for global in "${globals[@]}"; do
		read -p "Would you like to install $global? [Y/N] " -n 1;
		echo "";
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			sudo apt-get -y install $global
		fi;
  done
}

# Call the apt-install functions on the softwares list
apt-install

# Install PIP for python
easy_install pip

read -p "Would you like to install Node.js? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# Instal NVM to install Node.js
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.27.1/install.sh | bash
	echo "source ~/.nvm/nvm.sh" >> "${HOME}/.bash_profile"
	source ~/.bash_profile
	nvm install stable
	source ~/.bash_profile
	# Fix the node.js and node issue in Ubuntu
	ln -s /usr/bin/nodejs /bin/node
fi;

read -p "Would you like to install NPM globals? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo bash "/root/.npm_globals.sh"
fi;



# Call the apt-install functions on the softwares list
if [[! -z $NOTSUDOER ]]; then
apt-install
fi

read -p "Would you like to install diff-so-fancy? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -O $HOME/bin/diff-so-fancy
chmod a+x  $HOME/bin/diff-so-fancy
fi

read -p "Would you like to install mmake as  more helpful make alternative? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
go get github.com/tj/mmake/cmd/mmake
echo "alias make=mmake" >> $HOME/.aliases
fi

read -p "Would you like to install has for checking dependencies? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
wget https://raw.githubusercontent.com/kdabir/has/master/has -O $HOME/bin/has
chmod a+x $HOME/bin/has
fi
