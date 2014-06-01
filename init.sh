#!/usr/bin/env sh
while true
do
read -p "do you want to link $PWD to ~/.config/fish (Y/N)" yn
case $yn in
	[Yy]*)
		rm -rf ~/.config/fish;
		ln -sf $PWD ~/.config/fish;
		break;;
	[Nn]*) break;;
	*) echo "please answer yes or no";;
esac
done

while true
do
read -p "do you want to install fish (Y/N)" yn
case $yn in
	[Yy]*) sudo apt-get install fish;
		chsh -s /usr/bin/fish;
		break;;
	[Nn]*) break;;
	*) echo "please answer yes or no";;
esac
done

set -Ux PYTHONPATH ~/kivy/:~/cymunk/cymumk/python:~/KivEnt/kivent/
