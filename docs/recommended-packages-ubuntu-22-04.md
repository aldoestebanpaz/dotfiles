
# Installation of recommended Packages for Ubuntu 22.04.4 LTS (Jammy Jellyfish)

## General

### System information tools (aka. fetch scripts)

```bash
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt install fastfetch
```

## Packages

### Searching files in non-installed packages

```bash
sudo apt-get install apt-file
sudo apt-file update
```