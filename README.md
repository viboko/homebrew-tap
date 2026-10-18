# viboko/tap

Homebrew formulae for viboko's tools.

| Formula | What it is |
|---|---|
| [`flint-cli`](Formula/flint-cli.rb) | [flint](https://github.com/viboko/flint), a folder linter. Installs the `flint` command. (Homebrew's own `flint` is an unrelated maths library, hence the name.) |

## Install

```bash
brew install viboko/tap/flint-cli
```

Or `brew tap viboko/tap` and then `brew install flint-cli`.

## Updating a formula

Each formula installs a project's prebuilt release binaries. For a new
release, open a PR changing the version in each `url` and each `sha256`
to the one in the matching `.sha256` file attached to the GitHub Release.
CI (`brew test-bot`) installs and tests it on macOS and Linux; check it
locally with:

```bash
brew install --build-from-source viboko/tap/flint-cli
brew test viboko/tap/flint-cli
brew audit --strict --online viboko/tap/flint-cli
```

## License

Licensed under either of [Apache License, Version 2.0](LICENSE-APACHE) or
[MIT license](LICENSE-MIT) at your option. This covers the formulae and
workflows here; each tool they install has its own license.
