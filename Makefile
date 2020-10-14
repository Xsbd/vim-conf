# Makefile
pwd := $(shell pwd -LP)

link:
	@if [ ! . -ef ~/.vim ]; then ln -nfs "${pwd}" ~/.vim; fi
	@ln -nfs "${pwd}/.vimrc" ~/.vimrc
