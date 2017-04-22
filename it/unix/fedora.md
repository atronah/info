Fedora
======


Upgrade
-------

### use official tool (old version, before 22)

up to Fedora 22
```
dnf install fedup
fedup --network 22
```

### use official tool

up to Fedora 25
```
dnf install dnf-plugin-system-upgrade
dnf system-upgrade download --refresh --releasever=25
```

### use unofficial tool 

```bash
dnf install fedora-upgrade
fedora-upgrade
```

Packages
--------

- `dnf groupupdate 'Minimal Install'` - Check that minimal needed packages is installed
- `dnf grouplist` - Show available groups