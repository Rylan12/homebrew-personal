class Virtualenv < Formula
  desc "Tool for creating isolated virtual python environments"
  homepage "https://virtualenv.pypa.io"
  url "https://files.pythonhosted.org/packages/49/63/8e16d7f59ec7be34fbf57f9935e3ce1ab8b96cb6f1609ff30f16bbe7cf0d/virtualenv-20.2.1.tar.gz"
  sha256 "e0aac7525e880a429764cefd3aaaff54afb5d9f25c82627563603f5d7de5a6e5"
  license "MIT"

  bottle do
    root_url "https://github.com/Rylan12/homebrew-personal/releases/download/virtualenv-20.1.0"
    cellar :any_skip_relocation
    sha256 "37aa1efabdab67da88036e9c03591e37d774cfdc89fb17f2de06ae901976647f" => :catalina
    sha256 "ace1599b3eed044580874a196ab682da640f8623809bc8aec68b55727c5f3a8e" => :x86_64_linux
  end

  depends_on "python@3.9"

  resource "appdirs" do
    url "https://files.pythonhosted.org/packages/d7/d8/05696357e0311f5b5c316d7b95f46c669dd9c15aaeecbb48c7d0aeb88c40/appdirs-1.4.4.tar.gz"
    sha256 "7d5d0167b2b1ba821647616af46a749d1c653740dd0d2415100fe26e27afdf41"
  end

  resource "distlib" do
    url "https://files.pythonhosted.org/packages/2f/83/1eba07997b8ba58d92b3e51445d5bf36f9fba9cb8166bcae99b9c3464841/distlib-0.3.1.zip"
    sha256 "edf6116872c863e1aa9d5bb7cb5e05a022c519a4594dc703843343a9ddd9bff1"
  end

  resource "filelock" do
    url "https://files.pythonhosted.org/packages/14/ec/6ee2168387ce0154632f856d5cc5592328e9cf93127c5c9aeca92c8c16cb/filelock-3.0.12.tar.gz"
    sha256 "18d82244ee114f543149c66a6e0c14e9c4f8a1044b5cdaadd0f82159d6a6ff59"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz"
    sha256 "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259"
  end

  def install
    xy = Language::Python.major_minor_version Formula["python@3.9"].opt_bin/"python3"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{xy}/site-packages"
    resources.each do |r|
      r.stage do
        system Formula["python@3.9"].opt_bin/"python3", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{xy}/site-packages"
    system Formula["python@3.9"].opt_bin/"python3", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
  end

  test do
    (testpath/"test.py").write <<~EOS
      import six
      sum = 0
      for item in six.iteritems({'a': 14, 'b': 28}):
        sum += item[1]
      if sum != 42:
        exit(1)
    EOS
    system bin/"virtualenv", testpath/"venv"
    assert_match "Python #{Formula["python@3.9"].version}", shell_output("#{testpath}/venv/bin/python --version")
    system testpath/"venv/bin/pip", "install", "six"
    system testpath/"venv/bin/python", "test.py"
  end
end
