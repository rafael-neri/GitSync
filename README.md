GitSync
=======

Sync all Git repositories in a directory of repositories.

## Usage

First downlload the script `bash gitsync.bash` and now create a file named `cupcake.sync` (for example). Now edit this file and add the following to it:

````
repoDir="" #The directory of repositories you wish to sync
logFile="" #The file you wish to log to, set to `NONE` if you don't want logging
````

Now run `bash gitsync.bash cupcake.sync`.

## Dependancies

* `bash` - The script is written in bash.
* `sleep` - For  halting execution for user experience
* `git` - The script syncs Git repositories and hence requires Git to be installed.

## License

GitSync is licensed under the GNU GPL v3.
