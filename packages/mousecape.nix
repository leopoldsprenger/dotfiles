{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "mousecape";
  version = "tahoe";

  src = pkgs.fetchurl {
    url = "https://github.com/AdamWawrzynkowskiGF/Mousecape-TahoeSupport/releases/download/PreRelease-v01/Mousecape-Tahoe-PreRelease.zip";
    hash = "sha256-Ltg9EsCQkeabnQa3+zKLKg0L21Oma5TvA7KUklLdsWg=";
  };

  nativeBuildInputs = [
    pkgs.unzip
  ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -R Mousecape.app $out/Applications/
  '';
}
