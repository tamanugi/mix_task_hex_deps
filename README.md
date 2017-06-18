# MixTaskHexDeps

HexDeps is Print hex package info with deps_format like `{:hoge, "~> 1.0.0"}`.

# Usage

```
$ mix hex.deps httpoison poison credo
{:credo, "~> 0.8.1"},
{:poison, "~> 3.1.0"},
{:httpoison, "~> 0.11.2"}

$ mix hex.deps httpoison poison credo | pbcopy
# paste your mix.exs

```

## Installation

```
$ git clone https://github.com/tamanugi/mix_tasks_hex_deps.git
$ cd mix_tasks_hex_deps
$ mix do archive.build, archive.install
```
