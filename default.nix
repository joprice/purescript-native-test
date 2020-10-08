{ pkgs ? import <nixpkgs> { } }:
let
  easy-ps = import
    (pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "1ec689df0adf8e8ada7fcfcb513876307ea34226";
      sha256 = "12hk2zbjkrq2i5fs6xb3x254lnhm9fzkcxph0a7ngxyzfykvf4hi";
    })
    {
      inherit pkgs;
    };
  nodePackages = pkgs.callPackage ./node-build.nix { };
  inputs = {
    inherit (easy-ps) purs-0_13_8 purty spago pscid zephyr psc-package;
    inherit (pkgs) nodejs-12_x purescript-psa git;
    inherit (nodePackages) purescript-language-server;
    # TODO: make cross platform using nix
    # https://github.com/NixOS/nixpkgs/blob/617a3a64026338cc47fa47a5abf416a8d7314866/pkgs/development/libraries/qt-5/modules/qtwebview.nix#L13
    inherit (pkgs.darwin.apple_sdk.frameworks) CoreFoundation WebKit;
    inherit (pkgs) go gopls gcc;
  };
  buildInputs = builtins.attrValues inputs;
in
{
  inputs = inputs;
  inherit buildInputs;
  shell = pkgs.mkShell {
    inherit buildInputs;
  };
}
