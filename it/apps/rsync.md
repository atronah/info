# rsync


## example to sync data between main and reserve disks


```shell
rsync -auvh --relative --log-file=/Volumes/wd_cmr_1tb/$(date +%Y-%m-%d)_rsync.log /Volumes/wd_cmr_1tb/./ /Volumes/wd_smr_1tb --progress
```

where

- `/Volumes/wd_cmr_1tb` - main disk to store necessary data
- `/Volumes/wd_smr_1tb` - second/reserve disk to duplicate necessary data from main disk
- `/Volumes/wd_cmr_1tb/./` - source path to sync with making target pathes as relatives to `/./` catalog (because of `--relative` option)
- options
	- `-a` - archive mode; same as `-rlptgoD` (no `-H`: no preserve hard links)
		- `-r`/`--recursive` 
		- `-l`/`--links` - copy symlinks as symlinks
		- `-p`/`--perms` - preserve permissions 
		- `-t`/`--times` - preserve times
		- `-g`/`--group` - preserve group
		- `-o`/`--owner` - preserve owner (super-user only)
		- `-D` - same as `--devices --specials`
			- `--devices` - preserve device files (super-user only)
			- `--specials` - preserve special files
	- `u`/`--update` - skip files that are newer on the receiver
	- `v` - increase verbosity
	- `h`/`--human-readable` - output numbers in a more human-readable format
	- `--relative` - use relative path names (relative to the directory, indicated by the dot `.` in source path)
	- `--progress` - show progress during transfer
