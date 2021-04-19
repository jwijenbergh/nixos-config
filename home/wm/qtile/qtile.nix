{ stdenv, fetchFromGitHub, python37Packages, glib, cairo, pango, pkgconfig, libxcb, xcbutilcursor }:

let cairocffi-xcffib = python37Packages.cairocffi.override {
    withXcffib = true;
  };
in

python37Packages.buildPythonApplication rec {
  name = "qtile-${version}";
  version = "0.17.0";

  src = fetchFromGitHub {
    owner = "qtile";
    repo = "qtile";
    rev = "v${version}";
    sha256 = "0n1scjrk9pwjjivpsvp8gx2yqssk79hgsx5d0dlay9kk7bzvsx0w";
  };

  patches = [
    ./qtile-nix.patch
  ];

  postPatch = ''
    substituteInPlace libqtile/core/manager.py --subst-var-by out $out
    substituteInPlace libqtile/pangocffi.py --subst-var-by glib ${glib.out}
    substituteInPlace libqtile/pangocffi.py --subst-var-by pango ${pango.out}
    substituteInPlace libqtile/backend/x11/xcursors.py --subst-var-by xcb-cursor ${xcbutilcursor.out}
  '';

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ glib libxcb cairo pango python37Packages.xcffib ];

  pythonPath = with python37Packages; [ xcffib cairocffi-xcffib setuptools setuptools_scm ]; 

  postInstall = ''
    wrapProgram $out/bin/qtile \
      --run 'export QTILE_WRAPPER=$0' \
      --run 'export QTILE_SAVED_PYTHONPATH=$PYTHONPATH' \
      --run 'export QTILE_SAVED_PATH=$PATH'
  '';

  doCheck = false; # Requires X server #TODO this can be worked out with the existing NixOS testing infrastructure.

  meta = with stdenv.lib; {
    homepage = "http://www.qtile.org/";
    license = licenses.mit;
    description = "A small, flexible, scriptable tiling window manager written in Python";
    platforms = platforms.linux;
    maintainers = with maintainers; [ kamilchm ];
  };
}
