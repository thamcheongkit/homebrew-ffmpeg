class Ffmpeg < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  url "https://ffmpeg.org/releases/ffmpeg-5.1.2.tar.xz"
  sha256 "619e706d662c8420859832ddc259cd4d4096a48a2ce1eefd052db9e440eef3dc"
  # None of these parts are used by default, you have to explicitly pass `--enable-gpl`
  # to configure to activate them. In this case, FFmpeg's license changes to GPL v2+.
  license "GPL-2.0-or-later"
  revision 4
  head "https://github.com/FFmpeg/FFmpeg.git", branch: "master"

  livecheck do
    url "https://ffmpeg.org/download.html"
    regex(/href=.*?ffmpeg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  depends_on "pkg-config" => :build
  depends_on "aom" => :build
  depends_on "aribb24" => :build
  depends_on "dav1d" => :build
  depends_on "fontconfig" => :build
  depends_on "freetype" => :build
  depends_on "frei0r" => :build
  depends_on "gnutls" => :build
  depends_on "lame" => :build
  depends_on "libass" => :build
  depends_on "libbluray" => :build
  depends_on "librist" => :build
  depends_on "libsoxr" => :build
  depends_on "libvidstab" => :build
  depends_on "libvmaf" => :build
  depends_on "libvorbis" => :build
  depends_on "libvpx" => :build
  depends_on "opencore-amr" => :build
  depends_on "openjpeg" => :build
  depends_on "opus" => :build
  depends_on "rav1e" => :build
  depends_on "rubberband" => :build
  depends_on "sdl2" => :build
  depends_on "snappy" => :build
  depends_on "speex" => :build
  depends_on "srt" => :build
  depends_on "svt-av1" => :build
  depends_on "tesseract" => :build
  depends_on "theora" => :build
  depends_on "webp" => :build
  depends_on "x264" => :build
  depends_on "x265" => :build
  depends_on "xvid" => :build
  depends_on "xz" => :build
  depends_on "zeromq" => :build
  depends_on "zimg" => :build

  uses_from_macos "bzip2"
  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  fails_with gcc: "5"

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-pthreads
      --enable-version3
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
      --enable-ffplay
      --enable-gnutls
      --enable-gpl
      --enable-libaom
      --enable-libaribb24
      --enable-libbluray
      --enable-libdav1d
      --enable-libmp3lame
      --enable-libopus
      --enable-librav1e
      --enable-librist
      --enable-librubberband
      --enable-libsnappy
      --enable-libsrt
      --enable-libsvtav1
      --enable-libtesseract
      --enable-libtheora
      --enable-libvidstab
      --enable-libvmaf
      --enable-libvorbis
      --enable-libvpx
      --enable-libwebp
      --enable-libx264
      --enable-libx265
      --enable-libxml2
      --enable-libxvid
      --enable-lzma
      --enable-libfontconfig
      --enable-libfreetype
      --enable-frei0r
      --enable-libass
      --enable-libopencore-amrnb
      --enable-libopencore-amrwb
      --enable-libopenjpeg
      --enable-libspeex
      --enable-libsoxr
      --enable-libzmq
      --enable-libzimg
      --disable-libjack
      --disable-indev=jack
    ]

    # Needs corefoundation, coremedia, corevideo
    args << "--enable-videotoolbox" if OS.mac?
    args << "--enable-neon" if Hardware::CPU.arm?

    system "./configure", *args
    system "make"

    # system "make", "install"

    # # Build and install additional FFmpeg tools
    # system "make", "alltools"
    # bin.install Dir["tools/*"].select { |f| File.executable? f }

    # # Fix for Non-executables that were installed to bin/
    # mv bin/"python", pkgshare/"python", force: true
  end

#   test do
#     # Create an example mp4 file
#     mp4out = testpath/"video.mp4"
#     system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
#     assert_predicate mp4out, :exist?
#   end
end