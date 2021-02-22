{ stdenv, fetchurl, cmake, pkgconfig, glib, libX11, libXext, libXinerama, libXrandr, python3
, xdotool, xorg, xterm, runtimeShell
, nixosTests }:

stdenv.mkDerivation rec {
  pname = "herbstluftwm";
  version = "0.9.0";

  src = fetchurl {
    url = "https://herbstluftwm.org/tarballs/herbstluftwm-${version}.tar.gz";
    sha256 = "0vb1ksrdywbjbasyws7zb6zaaik2msbqgcic9ilv94vcmgkf6qki";
  };

  outputs = [
    "out"
  ];

  cmakeFlags = [
    "-DCMAKE_INSTALL_SYSCONF_PREFIX=${placeholder "out"}/etc"
    "-DWITH_DOCUMENTATION=OFF"
  ];

  nativeBuildInputs = [
    cmake
    pkgconfig
    python3
  ];

  buildInputs = [
    libX11
    libXext
    libXinerama
    libXrandr
  ];

  doCheck = true;

  checkInputs = [
    (python3.withPackages (ps: with ps; [ ewmh pytest xlib ]))
    xdotool
    xorg.xorgserver
    xorg.xsetroot
    xterm
  ];

  postPatch = ''
    patchShebangs doc/gendoc.py
    substituteInPlace share/autostart --replace /etc/xdg/herbstluftwm $out/etc/xdg/herbstluftwm
  '';

  meta = with stdenv.lib; {
    description = "A manual tiling window manager for X";
    homepage = "https://herbstluftwm.org/";
    license = licenses.bsd2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ thibautmarty ];
  };
}
