# my dotfiles

## how to use
1. `git clone --bare <git-repo-url> ~/.dotfiles.git`
2. `alias config='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'`
3. `config checkout`
4. `config config --local status.showUntrackedFiles no`

if you get error like this:
```
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    ...
Please move or remove them before you can switch branches.
Aborting
```
you'll need to delete those files that cause conflict or backup them.
here's a helpful script to backup all of the files that will be replaced by the ones in this repo:
```sh
mkdir ~/.dotfiles-backup
config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} \
mv {} ~/.dotfiles-backup/{}
```
or replace the last line with `rm {}` to remove files without making a backup. then, re-run command from step 3.

shoutout to StreakyCobra for sharing this method of managing dotfiles in this [HN thread.](https://news.ycombinator.com/item?id=11070797)
