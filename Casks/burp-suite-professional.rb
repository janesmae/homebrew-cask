cask "burp-suite-professional" do
  version "2021.8"
  sha256 "0968a79e120c99ded5b6414092aeadabf31e1a775bb477471cdc2a02d1e76b97"

  url "https://portswigger.net/burp/releases/download?product=pro&version=#{version}&type=MacOsx"
  name "Burp Suite Professional"
  desc "Web security testing toolkit"
  homepage "https://portswigger.net/burp/pro"

  livecheck do
    url "https://portswigger.net/burp/releases/professional/latest"
    strategy :header_match do |headers|
      headers["location"][%r{/professional[._-]community[._-]v?(\d+(?:-\d+)+)\?}i, 1].tr("-", ".")
    end
  end

  installer script: {
    executable: "Burp Suite Professional Installer.app/Contents/MacOS/JavaApplicationStub",
    args:       ["-q"],
    sudo:       true,
  }

  postflight do
    set_ownership "/Applications/Burp Suite Professional.app"
    set_permissions "/Applications/Burp Suite Professional.app", "a+rX"
  end

  uninstall delete: "/Applications/Burp Suite Professional.app"

  zap trash: "~/.BurpSuite"
end
