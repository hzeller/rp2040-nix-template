{ pkgs ? import <nixpkgs> {} }:
let
  local-pico-sdk = pkgs.pico-sdk.overrideDerivation (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "raspberrypi";
      repo = "pico-sdk";
      rev = "1.5.1";
      fetchSubmodules = true;
      hash = "sha256-GY5jjJzaENL3ftuU5KpEZAmEZgyFRtLwGVg3W1e/4Ho=";
    };
  });

  # The following is possible once
  # https://github.com/NixOS/nixpkgs/pull/321786 is merged
  # local-pico-sdk = pkgs.pico-sdk.override {
  #   withSubmodules = true;
  # };
in
pkgs.mkShell {
  buildInputs = with pkgs;
    [
      gcc-arm-embedded
      local-pico-sdk
      cmake python3   # build requirements for pico-sdk
      udisks          # Interact with bootloader filesystem
      tio             # terminal program to interface with serial
    ];
  shellHook = ''
   export PICO_SDK_PATH=${local-pico-sdk}/lib/pico-sdk
  '';
}
