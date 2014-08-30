#!/usr/bin/env sh
while true
do
read -p "do you want to link $PWD to ~/.config/fish (Y/N)" yn
case $yn in
	[Yy]*)
		mkdir -p ~/.comfig/;
		rm -rf ~/.config/fish;
		ln -sf $PWD ~/.config/fish;
		break;;
	[Nn]*) break;;
	*) echo "please answer yes or no";;
esac
done

while true
do
read -p "do you want to install fish? (Y/N)" yn
case $yn in
	[Yy]*) sudo apt-get install -y fish groff;
		chsh -s /usr/bin/fish;
		break;;
	[Nn]*) break;;
	*) echo "please answer yes or no";;
esac
done

while true
do
read -p "do you want to set needed variables? (Y/N)" yn
case $yn in
	[Yy]*) fish $PWD/init_variables.fish;
		break;;
	[Nn]*) break;;
	*) echo "please answer yes or no";;
esac
done
