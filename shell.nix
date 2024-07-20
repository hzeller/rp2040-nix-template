# Until
# https://github.com/NixOS/nixpkgs/pull/321786 or
# https://github.com/NixOS/nixpkgs/pull/260566 is merged, do this
# manually.
#{ pkgs ? import <nixpkgs> {} }:
{ pkgs ? import /home/hzeller/src/my/nixpkgs {} }:
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
