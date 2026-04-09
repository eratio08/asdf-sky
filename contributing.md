# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test sky https://github.com/eratio08/asdf-sky.git "sky --help"
asdf plugin test sky . --asdf-tool-version 0.7.24 "sky --help"
```

Tests are automatically run in GitHub Actions on push and PR.
