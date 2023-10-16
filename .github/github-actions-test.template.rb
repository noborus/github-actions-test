class github-actions-test < Formula
  desc "Tools for executing SQL queries to CSV, LTSV, JSON and TBLN"
  homepage "https://github.com/noborus/github-actions-test/"
  version  "{{ version }}"

  on_macos do
    if Hardware::CPU.arm?
      url "{{ DARWIN_ARM64_URL }}"
      sha256 "{{ DARWIN_ARM64_SHA256 }}"
      def install
        bin.install "github-actions-test"
      end
    end
    if Hardware::CPU.intel?
      url "{{ DARWIN_AMD64_URL }}"
      sha256 "{{ DARWIN_AMD64_SHA256 }}"
      def install
        bin.install "github-actions-test"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "{{ LINUX_ARM64_URL }}"
      sha256 "{{ LINUX_ARM64_SHA256 }}"
      def install
        bin.install "github-actions-test"
      end
    end

    if Hardware::CPU.intel?
      url "{{ LINUX_AMD64_URL }}"
      sha256 "{{ LINUX_AMD64_SHA256 }}"
      def install
        bin.install "github-actions-test"
      end
    end
  end

  test do
    assert_equal "3\n", pipe_output("#{bin}/github-actions-test 'select count(*) from -'", "a\nb\nc\n")
  end
end
