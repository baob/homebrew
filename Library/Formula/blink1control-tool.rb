class Blink1controlTool < Formula
  desc "Control blink(1) indicator light via Blink(1)control API"
  homepage "https://blink1.thingm.com/"
  url "https://github.com/todbot/blink1/archive/v1.97.tar.gz"
  sha256 "974722b466249ee47ec27659b160d2e4fd0c2bc3732d009f180f8ffb53dc5d92"
  head "https://github.com/todbot/blink1.git"

  bottle do
    cellar :any
    sha256 "5e22891add69771089048f69fa5f7403e0c406c59a2eff232c63c19fe9b292d7" => :mavericks
  end

  def install
    cd "commandline" do
      cd "blink1control-tool" do
        system "wget http://curl.haxx.se/download/curl-7.37.1.tar.gz ; echo $?"
        system "tar xvzf curl-7.37.1.tar.gz"
        cd "curl-7.37.1" do
          system "./configure --prefix `pwd`/../curl-mac --disable-shared --disable-ldap --without-zlib --without-libssh2 --without-ssl --disable-crypto-auth"
          system "make"
          system "make install"
        end
        system "git clone git@github.com:udp/json-parser.git"
        cd "json-parser" do
          system "git checkout v1.1.0"
        end
        system "make"
        bin.install "blink1control-tool"
      end
    end
  end

  test do
    system bin/"blink1control-tool", "--version"
  end
end
