# Demitri Muna’s Bash Scripts!

A repository for my personal BASH scripts and general Unix environment setup to clone when I set up a new server account. Open for anyone to pillage and plunder.

### Installation

* Copy the `bash_scripts` to your home directory, renaming it to `.bash_scripts.
* Select your OS, then *append* the contents of each file in the folder to a file with the same name in your home directory, but with a `.` prepended to it.
* Or just copy/paste the code below. But you should really look at the files first to see what they are doing.

#### Mac

```
cp -R bash_scripts $HOME/.bash_scripts
cd home_directory_files_Mac
cat pythonstartup >> $HOME/.pythonstartup
cat bash_profile >> $HOME/.bash_profile
cat inputrc >> $HOME/.inputrc
```

#### Linux

```
cp -R bash_scripts $HOME/.bash_scripts
cd home_directory_files_Linux
cat pythonstartup >> $HOME/.pythonstartup
cat bashrc >> $HOME/.bashrc
cat inputrc >> $HOME/.inputrc
```

#### Other Configuration Files

Other random configuration files for things like curl, wget, and vi can be found in the `Others` folder and should be added manually. Be sure to rename each file with a `.` prefix and place in your home directory.

### Organization

A common setup is to place environment files (e.g. alias definitions, paths) directly in one's home directory. I find these get lost among everything else, so I place them in the directory `$HOME/.bash_scripts`. Another startup file will call `$HOME/.bash_scripts/_init.sh` to execute the files in this directory. Which file to call it from depends on the system; `.bash_profile` on the Mac, and typically `.bashrc` on Linux.

Also included is a template file for a `.ssh/config` with my standard settings.

### Caveats

These settings are mine and largely customized for my environment and preferences. This repository is not intended to be a general setup for everybody, and one should use caution in copying it wholesale. You should probably assume extreme malicious intent and read through the files - installing something like this can potentially give someone full access to your system.

That said, I believe everything here is safe. There is a lot here that makes working on the command line much more pleasant over most default settings. And colorful.

Have any suggestions and improvements? Let me know!
