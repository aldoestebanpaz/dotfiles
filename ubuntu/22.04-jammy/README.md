# dotfiles for Ubuntu 22.04 LTS (Jammy Jellyfish)

## Installation

### Run the installation script

```sh
cd ubuntu/22.04-jammy
chmod +x install.sh
sudo -s bash ./install.sh
# or:
#   sudo -i sh -c "cd '$PWD'; ./install.sh"
```

### Configure git and debian variables

```sh
FULLNAME="Foo Bar"
EMAIL="foobar@email.com"

cat >>~/.bashrc <<EOF
export DEBFULLNAME="${FULLNAME}"
export DEBEMAIL="${EMAIL}"
EOF

git config --global user.name "${FULLNAME}"
git config --global user.email "${EMAIL}"
```
