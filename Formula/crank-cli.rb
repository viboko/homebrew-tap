# Prebuilt binaries from crank's GitHub Release. To update for a new
# release, change the version in each target's url and replace its sha256
# with the one in the matching `.sha256` file attached to that release.
class CrankCli < Formula
  desc "Code generator: renders Tera templates against YAML data, per a .crank file"
  homepage "https://crank.viboko.dev"
  license any_of: ["MIT", "Apache-2.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/viboko/crank/releases/download/v0.1.0/crank-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "8d96e8e88b2a08ac4d1e20eddcad214777bce74d40e72ebb663a201dc9b6d0b4"
    end
    on_intel do
      url "https://github.com/viboko/crank/releases/download/v0.1.0/crank-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "9aa7d381e89710746a5dd5ec25733c489bc34b2e7d7c74b26481d8fc00d7c0f1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/viboko/crank/releases/download/v0.1.0/crank-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a07c541f3694fa9c758aae6d6df4da7309ace40d2b8e133f4731e898caf9fc1f"
    end
    on_intel do
      url "https://github.com/viboko/crank/releases/download/v0.1.0/crank-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a8db8f86fa11df1285f0f13757a7af240da0db32ad1dc93ecb61c1412cb82f24"
    end
  end

  def install
    bin.install "crank"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/crank --version")

    # A folder of its own: Homebrew leaves files of its own in testpath.
    project = testpath/"project"
    project.mkpath
    (project/".crank").write <<~YAML
      taskGroups:
        - name: greeting
          object: data.yaml
          tasks:
            - template: hello.txt.tera
              output: hello.txt
    YAML
    (project/"data.yaml").write "name: world\n"
    (project/"hello.txt.tera").write "Hello, {{ name | upper }}!\n"
    assert_match "hello.txt (created)", shell_output("#{bin}/crank #{project}")
    assert_equal "Hello, WORLD!\n", (project/"hello.txt").read

    # Pathname#write won't overwrite a file, so File.write changes the data.
    File.write(project/"data.yaml", "name: brew\n")
    assert_match "hello.txt (would modify)", shell_output("#{bin}/crank --check #{project}", 1)
  end
end
