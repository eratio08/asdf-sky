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

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add sky
# or
asdf plugin add sky https://github.com/eratio08/asdf-sky.git
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

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/eratio08/asdf-sky/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Eike Lurz](https://github.com/eratio08/)
