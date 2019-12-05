# Style Guide

These are the coding style conventions we adhere to.

## Installation

docker-compose build pronto

Create a `.rubocop.yml` in every repository with this content:

```bash
echo "inherit_from: https://raw.githubusercontent.com/bukowskis/style-guide/master/rubocop.yml" > .rubocop.yml
```

Copy `.scss-lint.yml` to your code repository it in sync with this repository.
And wait for https://github.com/mmozuras/pronto-scss/issues/6 to be solved.

```bash
# Provided your current directory is this repository
cp scss-lint.yml PATH/TO/YOUR/CODE/REPO/.scss-lint.yml
```

Copy `.slim-lint.yml` to your `$HOME` directory and keep it in sync with this repository.

```bash
# Provided your current directory is this repository
cp slim-lint.yml ~/.slim-lint.yml
```

## Usage

In your feature branch, simply run the following command to run the linters an all code
changes compared to master.

```bash
~/Projects/style-guide/bin/pronto

# You can also just run one type of linter
~/Projects/style-guide/bin/pronto pronto run -r rubocop
~/Projects/style-guide/bin/pronto pronto run -r scss
```

If you have not commited your changes yet, you can use the following command to lint
all files that have changed compared to HEAD.

```bash
~/Projects/style-guide/bin/pronto pronto run --index
```
