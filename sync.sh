rm nvim -rf; cp -r ~/.config/nvim ./
rm emacs/* -rf; cp -r ~/.emacs.d/init.el ~/.emacs.d/autosave.el ./emacs
git add .

