class Yale < Formula
  include Language::Python::Virtualenv
  include Language::Python::Shebang

  desc "A CLI tool for Yale University"
  homepage "https://github.com/ErikBoesen/yale"
  head "https://github.com/ErikBoesen/yale.git"
  license "MIT"

  depends_on "python"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/6d/78/f8db8d57f520a54f0b8a438319c342c61c22759d8f9a1cd2e2180b5e5ea9/certifi-2021.5.30.tar.gz"
    sha256 "2bbf76fd432960138b3ef6dda3dde0544f27cbf8546c458e60baf371917ba9ee"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/68/32/95ddb68b9abeb89efd461852cdff5791d42fc5e4c528536f541091ffded3/charset-normalizer-2.0.5.tar.gz"
    sha256 "7098e7e862f6370a2a8d1a6398cd359815c45d12626267652c3f13dec58e2367"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/cb/38/4c4d00ddfa48abe616d7e572e02a04273603db446975ab46bbcd36552005/idna-3.2.tar.gz"
    sha256 "467fbad99067910785144ce333826c71fb0e63a425657295239737f7ecd125f3"
  end

  resource "pick" do
    url "https://files.pythonhosted.org/packages/17/88/2bb885d8cc38f50d874e96e8df9fdaff6ef15b97bd85639d44438347b0e1/pick-1.0.0.tar.gz"
    sha256 "03f13d4f5bfe74db4b969fb74c0ef110ec443978419d6c0f1f375a0d49539034"
  end

  resource "pyfiglet" do
    url "https://files.pythonhosted.org/packages/f9/02/48293654fb2e4fdeb4d927f00a380230a832744b6c9af757373a72d018d1/pyfiglet-0.8.post1.tar.gz"
    sha256 "c6c2321755d09267b438ec7b936825a4910fec696292139e664ca8670e103639"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/a0/a4/d63f2d7597e1a4b55aa3b4d6c5b029991d3b824b5bd331af8d4ab1ed687d/PyYAML-5.4.1.tar.gz"
    sha256 "607774cbba28732bfa802b54baa7484215f530991055bb562efbed5b2f20a45e"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/e7/01/3569e0b535fb2e4a6c384bdbed00c55b9d78b5084e0fb7f4d0bf523d7670/requests-2.26.0.tar.gz"
    sha256 "b8aa58f8cf793ffd8782d3d8cb19e66ef36f7aba4353eec859e74678b01b07a7"
  end

  resource "termcolor" do
    url "https://files.pythonhosted.org/packages/8a/48/a76be51647d0eb9f10e2a4511bf3ffb8cc1e6b14e9e4fab46173aa79f981/termcolor-1.1.0.tar.gz"
    sha256 "1d6d69ce66211143803fbc56652b41d73b4a400a2891d7bf7a1cdf4c02de613b"
  end

  resource "Unidecode" do
    url "https://files.pythonhosted.org/packages/df/11/60a304d3bfa84173f0bfb64f81e26ac5b0bff4c657d8fb6c26ff89ab8240/Unidecode-1.3.1.tar.gz"
    sha256 "6efac090bf8f29970afc90caf4daae87b172709b786cb1b4da2d0c0624431ecc"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/4f/5a/597ef5911cb8919efe4d86206aa8b2658616d676a7088f0825ca08bd7cb8/urllib3-1.26.6.tar.gz"
    sha256 "f57b4c16c62fa2760b7e3d97c35b255512fb6b59a259730f36ba32ce9f8e342f"
  end

  resource "yalebuildings" do
    url "https://files.pythonhosted.org/packages/a5/81/05885d096f0a457f2c6c1189c87e36479ef0773b47d4fdc4ff3c9f867022/yalebuildings-0.1.0.tar.gz"
    sha256 "0cb17c19cb23ed4c0edc80c580486479ea1e8b20145200ae55885fb880967943"
  end

  resource "yalecourses" do
    url "https://files.pythonhosted.org/packages/07/68/86c8d65c91b58f3ebf2e64c5be7afaf5f38ab02228b512bb7c6db2de4fca/yalecourses-0.1.5.tar.gz"
    sha256 "ad1587893388d11f7217756069f5e1a54237c2eb60bb2e9366ac4b5e345f1ea9"
  end

  resource "yaledining" do
    url "https://files.pythonhosted.org/packages/96/05/6e221d221ad379a1a80874a15dbe17d39a5f4787e0f8a715eb57952f9ee4/yaledining-2.0.0.tar.gz"
    sha256 "5deda422779cd2719ff3ead029bdaecb118c86adcc9bbc2ed0cdfd629d0e3d13"
  end

  resource "yalelaundry" do
    url "https://files.pythonhosted.org/packages/2d/ed/3f1f3a6411f7ccd4378053d9ff3ab9665e4f4806dbe260357acf1e9aadc5/yalelaundry-0.3.0.tar.gz"
    sha256 "15fd4efee66cda46a4aae7fe24b2c57ec0fea9b844d187b14a1fe861348cb2e2"
  end

  resource "yaleorgdirectory" do
    url "https://files.pythonhosted.org/packages/6a/5b/b95d5afc3eaa43aed615dfb51a7416df5e0d5e3fe35c7d543d35af025e02/yaleorgdirectory-0.2.0.tar.gz"
    sha256 "0522bba4b13e11e55edc2a712095db2d6bd625bb250d570e903193bd98da0b67"
  end

  resource "yalies" do
    url "https://files.pythonhosted.org/packages/65/d9/0d5593d5c57e676b6ea24aaea73214c3f09abd619596d1903f0546a08473/yalies-1.2.0.tar.gz"
    sha256 "0ca0ae11187beda98b3eb258923eaff9022400dee45b7eac3eac0e3beedf506d"
  end

  def install
    venv = virtualenv_create(libexec, Formula["python"].opt_bin/"python3")
    venv.pip_install resources

    rw_info = python_shebang_rewrite_info(libexec/"bin/python")
    rewrite_shebang rw_info, "yale"

    bin.install "yale"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test yale`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
