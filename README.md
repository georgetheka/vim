# MYIDE


## Background

This repo contains a vim setup which I use as a universal IDE for most things:

* python
* c/c++
* bash / shell
* golang
* rust
* javascript
* sql

This setup is not suitable for Java, C#, or Mobile development.

## Usage

To setup vim run the following:

```
sh install.sh
```

which will, in turn, take the following actions:

- backup current .vimrc and .vim folder into a zip archive file
- set up new packages by installing dependencies
- create new .vimrc with a default configuration
