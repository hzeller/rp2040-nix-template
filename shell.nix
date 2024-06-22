# Requires https://github.com/NixOS/nixpkgs/pull/321786
{ pkgs ? import <nixpkgs> {} }:
let
  pico-sdk = pkgs.pico-sdk.override {
    withSubmodules = true;
  };
in
pkgs.mkShell {
  buildInputs = with pkgs;
    [
      gcc-arm-embedded
      pico-sdk
      cmake python3   # build requirements for pico-sdk
      udisks          # Interact with bootloader filesystem
      tio             # terminal program to interface with serial
    ];
  shellHook = ''
   export PICO_SDK_PATH=${pico-sdk}/lib/pico-sdk
  '';
}
