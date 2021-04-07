{ pkgs, lib, fetchFromGitHub, rust, gtk3, cairo, glib, atk, pango, gdk-pixbuf, gdk-pixbuf-xlib, pkg-config }:

let mkRustPlatform = pkgs.callPackage ./rustplatform.nix {};

    rustPlatform = mkRustPlatform {
      date = "2021-04-06";
      channel = "nightly";
    };

in rustPlatform.buildRustPackage rec {
  name = "eww";
  src = fetchFromGitHub {
    owner = "elkowar";
    repo = name;
    rev = "11f595be2c7a08d276b6c8ce514a7a8d9d16ea95";
    sha256 = "0yhpqbsdby5ifh8z697zch3q8nsxy5q331q2kj9si6hhg08dx5sv";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    gtk3
    cairo
    glib
    atk
    pango
    gdk-pixbuf
    gdk-pixbuf-xlib
  ];

  checkPhase = null;
  cargoSha256 = "04knn9mrrkl0qfzajmxfg9g0h9ag1qm21bi2fzrngxyk4rcdin59";

  meta = with lib; {
    description = "A standalone widget system made in Rust to add AwesomeWM like widgets to any WM";
    homepage = "https://github.com/elkowar/eww";
    license = licenses.mit;
  };
}
