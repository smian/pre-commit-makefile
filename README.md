# Introduction
[![CircleCI](https://circleci.com/gh/smian/pre-commit-makefile.svg?style=svg)](https://circleci.com/gh/smian/pre-commit-makefile)

Useful Git [pre-commit](http://pre-commit.com) hooks when using Makefiles such as generating documentation in
README.md.
 
It uses [Yelp's pre-commit](http://pre-commit.com/) framework for adding git hooks locally.

## Dependencies

* [`bash`](https://www.gnu.org/software/bash/bash.html)
* [`perl`](https://www.perl.org/)
* [`git`](https://github.com/git/git)

## Usage

### Step 1: Install the pre-commit package (MAC OS):

```
brew install pre-commit
```

_For operating systems, other than macOS, check the [official documentation](http://pre-commit.com/#install)_


### Step 2: Add the following to `.pre-commit-config.yaml`:

```
cat <<EOF > .pre-commit-config.yaml
- repo: git://github.com/smian/pre-commit-makefile
  sha: master
  hooks:
    - id: makefile-doc
EOF
```

### Step 3: Install the git pre-commit hook to your local project:

```
pre-commit install
```

If you want to run the checks on-demand (outside of git hooks), run after you when through the setup below:

```
pre-commit run --all-files --verbose
```

### Step 4: Create a Makefile and define a `make help` target:

Define `make help` target that outputs a list of targets with documentation. You can follow the self-documenting 
[Makefile](http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html) format or take the starter 
[Makefile](tests/Makefile) under`test/Makefile`.

### Step 5: Add Markers in README.md:

Add the following markers to the README.md files that are in the same directory as the Makefile:

`<!-- START makefile-doc -->` 

`<!-- END makefile-doc -->` 

`makefile-doc` will add or update documentation generated by `make help` between the markers in the README.md 
files that are located in the same folder as the Makefile. 

It will only scan for files named strictly `Makefile` in the all directories and insert the documentation into 
`README.md` files in the same directories.

## License

The code in this repo is licensed under the [MIT License](LICENSE).
