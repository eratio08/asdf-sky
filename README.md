<div align="center">

# asdf-sky [![Build](https://github.com/eratio08/asdf-sky/actions/workflows/build.yml/badge.svg)](https://github.com/eratio08/asdf-sky/actions/workflows/build.yml) [![Lint](https://github.com/eratio08/asdf-sky/actions/workflows/lint.yml/badge.svg)](https://github.com/eratio08/asdf-sky/actions/workflows/lint.yml)

[sky](https://github.com/anzellai/sky) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `git`, `tar`, and standard [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `GITHUB_API_TOKEN` is optional, but recommended in CI to avoid GitHub rate limits when listing versions.
- `go` is not required to install the `sky` CLI with this plugin, but it is required for normal `sky` workflows because Sky compiles to Go.

# Install

Plugin:

```shell
asdf plugin add sky https://github.com/eratio08/asdf-sky.git
# or use the short name once the plugin is indexed
asdf plugin add sky
```

sky:

```shell
# Show all installable versions
asdf list-all sky

# Install specific version
asdf install sky latest

# Set a version globally (on your ~/.tool-versions file)
asdf global sky latest

# Now sky commands are available
sky --help
```

Note: this plugin only supports upstream GitHub releases that publish `.tar.gz` assets. Older uncompressed release binaries are not supported and are excluded from `asdf list-all sky`.

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/eratio08/asdf-sky/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Eike Lurz](https://github.com/eratio08/)
