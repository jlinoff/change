# change
[![Releases](https://img.shields.io/github/release/jlinoff/change.svg?style=flat)](https://github.com/jlinoff/change/releases)

Python script to change the contents or names of a set of files using
regular expressions.

I find it handy for changing variable names and version numbers on a
project.

To use it you specify the old pattern, the new pattern and the list of
files.

The patterns are in python regular expression format which makes it
easy to change text that contains things like forward slashes.

Here is a detailed example thats shows how to change foo to bar
in several files and stores the results in the local tmp directory
tree. To see other examples look at test/test.sh.

```bash
    $ tree example/
      example
      ├── foo-bar.txt
      └── foo.txt
      
      0 directories, 2 files

    $ cat foo.txt
    foo foo

    $ cat foo-bar.txt
    foo foo
    
    $ change -p tmp/ foo bar foo.txt foo-bar.txt
    
    $ tree tmp
      tmp
      ├── bar-bar.txt
      └── bar.txt
    
      0 directories, 2 files
```


If you want to substitute characters that used in regular expressions
like '.', you must escape it with a backslash `'\.'`.

If you want to only replace words use `'\b'` like this `'\bfoobarspam\b'`.

For other options see the documentation for Python regular expressions.
