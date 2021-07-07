<h1 align='center'>My vim configuration</h1>

## Dependencies
>    git

## Install
In Debian/ubuntu run the install script from wherever you cloned this repository
```bash
./install-vim-deb
```

__OR__
clone this repository to your home directory as .vim
```bash
git clone https://github.com/sbd8/.vim.git ~/.vim
```
symlink .vimrc
```bash
ln -s ~/.vim/.vimrc ~/.vimrc
```
<br />
<br />

#### If you want to create your vim configuartion read the following:

<br />
<br />
<h1 align='center'>Configuring Vim from Scratch</h1>

<p align='center'>
<em>A pragmatic guide to setting up VIM</em>
</p>
<br />

### Getting started

- [Install Vim](#install)
- [Back up your existing config](#backup)
- [Create ~/.vim](#vimpath)
- [Create your .vimrc](#vimrc)
- [Set up symlinks](#symlinks)

### Customizations

- [Maintaining Sanity](#sanity)
- [Pathogen](#pathogen)
- [Install Plugins with Git, using submodules](#git)
- [Your own Plugin](#own)

### Moving forward

- [Learn more about Vim](#more)
<br />

### Install Vim <a id='install'></a>

> (Skip this step if you've already installed Vim.)

- **Vim on Linux** 

  ```bash
  sudo pacman -S gvim         # Arch Linux
  sudo apt install vim        # Ubuntu
  ```
<br />

### Back up your existing Vim config <a id='backup'></a>

> (Skip this step if you're setting up a fresh installation of Vim.)

```bash
mv ~/.vimrc ~/.vimrc_bk~
mv ~/.vim ~/.vim_bk~
```
<br />

### Create your ~/.vim <a id='vimpath'></a>

```sh
mkdir -p ~/.vim
cd ~/.vim
```
<br />

### Create your .vimrc <a id='vimrc'></a>

```bash
cd ~/.vim
touch .vimrc
```
<br />

### Set up symlinks using make <a id='symlinks'></a>

In `~/.vim`, create a file called `Makefile` and add this in:

```bash
#### Makefile
pwd := $(shell pwd -LP)

link:
	@if [ ! . -ef ~/.vim ]; then ln -nfs "${pwd}" ~/.vim; fi
	@ln -nfs "${pwd}/.vimrc" ~/.vimrc
```

After creating it, just run `make link`. 

```bash
#### Before doing this, make sure you don't have ~/.vimrc (careful!)
rm ~/.vimrc

#### Set up symlinks
cd ~/.vim
make link
```
<br />

### Maintaining Sanity <a id='sanity'></a>

* Version control using git.

```
#### Version it using Git
git init
git commit -m "Initial commit" --allow-empty
```

* Minimize the number of lines you put int your `~/.vimrc`. <br>

Vanilla Vim supports splitting plugins into multiple files.
There are a number of different directories you can create under [~/.vim] that mean various things.
> For more details See: [Learn Vim Script the Hard Way](http://learnvimscriptthehardway.stevelosh.com/chapters/42.html)

Basically, we put vim script (plugins) we want:
  1. to always load with vim start in `~/.vim/plugin/`.
  2. to load dependent on file type in `~/.vim/ftplugin`.
  3. to load every time Vim starts, but after the files in `~/.vim/plugin/` in `~/.vim/after`.
  4. to load when needed in `~/.vim/autoload`.

It's better to use plugin manager to manage 3rd party code. You can also write your own plugin to load your defaults rather than writing to `~/.vimrc`.
<br />
<br />

### Install pathogen <a id='pathogen'></a>

[Pathogen](https://github.com/tpope/vim-pathogen) is used for managing plugins. Type the following in terminal to install it:

```bash
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```

Add this to your ~/.vim/.vimrc:
```
execute pathogen#infect()
syntax on
filetype plugin indent on
```

> For more details See: [pathogen](https://github.com/tpope/vim-pathogen) _(github.com)_
<br />

### Install Plugins with Git, using submodules <a id='git'/>

``` bash
#### Install (solarized colors theme here taken as an example)
$ cd ~/.vim/bundle
$ git submodule init
$ git submodule add https://github.com/altercation/vim-colors-solarized.git

#### Update
$ cd ~/.vim
$ git pull

#### Remove
$ cd ~/.vim
$ git submodule deinit -f bundle/vim-colors-solarized
$ git rm -rf bundle/vim-colors-solarized
$ rm -rf .git/modules/bundle/vim-colors-solarized
```

> For more details See: [How to use Tim Pope's Pathogen](https://gist.github.com/romainl/9970697) _(gist)_
<br />

### Your own Plugin <a id='own'></a>

Put your `*.vim` file in `~/.vim/plugin/` directory. Better still, let pathogen handle it by putting it in `~/.vim/bundle/*/plugin/`.

Your plugin file should look like this:

```
" licencesing and ownership information (as comments)

if exists('g:loaded_pluginname') || &compatible
  finish
else
  let g:loaded_pluginname = 'yes'
endif

" vim commands
...
```

Only keep your defaults in the plugin. <br>
Additional settings need not go to the `~/.vimrc` file. Rather put it in a separate script in the
`~/.vim/after/plugin` directory.
<br />
<br />
<br />

### More! <a id='more'></a>

Here are some more resources to look at:

- [vim-from-scratch](https://github.com/rstacruz/vim-from-scratch) inspired this guide.

- [mhinz/vim-galore](https://github.com/mhinz/vim-galore#readme) has a lot of tips on learning Vim.

- [devhints.io/vim](http://devhints.io/vim) is a quick reference on Vim.

- [Learn vimscript the hard way](http://learnvimscriptthehardway.stevelosh.com/) is a free book on Vim scripting.

- [vim-galore plugins](https://github.com/mhinz/vim-galore/blob/master/PLUGINS.md) is a curated list of common Vim plugins.

