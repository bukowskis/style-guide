# Style Guide

These are the coding style conventions we adhere to.

## Installation

Install these gems:

```bash
gem install pronto
gem install pronto-rubocop
gem install pronto-scss
```

Create a `.rubocop.yml` in every repository with this content:

```bash
echo "inherit_from: https://raw.githubusercontent.com/bukowskis/style-guide/master/rubocop.yml" > .rubocop.yml
```

Symlink `.scss-lint.yml` to your `$HOME` directory:

```bash
# Provided your current directory is this repository
ln -s scss-lint.yml ~/.scss-lint.yml
```

## Usage

In your feature branch, simply run the following command to run the linters an all code
changes compared to master.

```bash
pronto run
```

If you have not commited your changes yet, you can use the following command to lint
all files that have changed compared to HEAD.

```bash
pronto run --index
```
