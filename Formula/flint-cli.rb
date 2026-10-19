# Prebuilt binaries from flint's GitHub Release. To update for a new
# release, change the version in each target's url and replace its sha256
# with the one in the matching `.sha256` file attached to that release.
class FlintCli < Formula
  desc "Folder linter: checks a project's files and folders against an allow-list"
  homepage "https://flint.viboko.dev"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/viboko/flint/releases/download/v0.2.0/flint-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "446f565221ef224b1498cd5c40d58528294ab9f93f8e6c4079bf4eee76f6dd03"
    end
    on_intel do
      url "https://github.com/viboko/flint/releases/download/v0.2.0/flint-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "05767715a68b6434095e4114961a87f53c4675764627c1ba46a0374d365271c7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/viboko/flint/releases/download/v0.2.0/flint-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2a60bcc29175787c257286eea04757023f2636e763bef8e5be5dda5a1637faa2"
    end
    on_intel do
      url "https://github.com/viboko/flint/releases/download/v0.2.0/flint-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2ee47c1dcc995baf2042cabc55c72e3937b7b94c4bcb5f27685b526f4dd13a9e"
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
