# Prebuilt binaries from flint's GitHub Release. To update for a new
# release, change the version in each target's url and replace its sha256
# with the one in the matching `.sha256` file attached to that release.
class FlintCli < Formula
  desc "Folder linter: checks a project's files and folders against an allow-list"
  homepage "https://flint.viboko.dev"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/viboko/flint/releases/download/v0.1.0/flint-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "4f8dcb1a17d215a4061488387af9efbef06c014dfb20a10cae436497d2aef4ea"
    end
    on_intel do
      url "https://github.com/viboko/flint/releases/download/v0.1.0/flint-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "54395d038a08d6cd6f8cc8566a2abafce8d7012256cdec47a11004fae544be5c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/viboko/flint/releases/download/v0.1.0/flint-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cf1c4bf5155f78b08d0a83c9488ceaf9e9a898398fe9a40f8846eae2c4e3cec5"
    end
    on_intel do
      url "https://github.com/viboko/flint/releases/download/v0.1.0/flint-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ee7ae80298386d8ab85cc712672ba71a87021c313bf904c6b38810cddc262c5b"
    end
  end

  def install
    bin.install "flint"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/flint --version")

    # A folder of its own: Homebrew leaves files of its own in testpath.
    project = testpath/"project"
    project.mkpath
    (project/".flint").write "README.md\n"
    (project/"README.md").write "hello\n"
    assert_match "All files match", shell_output("#{bin}/flint #{project}")

    (project/"stray.txt").write "not allowed\n"
    assert_match "stray.txt", shell_output("#{bin}/flint #{project}", 1)
  end
end
